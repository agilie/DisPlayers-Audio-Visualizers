//
//  PlayRecordViewController.m
//  Equalizers
//
//  Created by Michael Liptuga on 07.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "PlayRecordViewController.h"

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/CALayer.h>

//Custom Views
#import "DPMainEqualizerView.h"
#import "DPHistogramEqualizerView.h"
#import "DPRollingEqualizerView.h"
#import "DPWaveEqualizerView.h"
#import "DPCircleWaveEqualizer.h"
#import "SettingsMenuView.h"
#import "ColorSettingsView.h"
#import "GeneralSettingsView.h"

@interface PlayRecordViewController () <EZAudioPlayerDelegate, SettingsMenuViewDelegate, ColorSettingsViewDelegate, GeneralSettingsViewDelegate, EZMicrophoneDelegate>

@property (weak, nonatomic) IBOutlet UIButton   *backButton;
@property (weak, nonatomic) IBOutlet UIButton   *recordButton;
@property (weak, nonatomic) IBOutlet UIButton   *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton   *playButton;
@property (weak, nonatomic) IBOutlet UIButton   *stopButton;

@property (weak, nonatomic) IBOutlet UIView     *navigationView;

@property (weak, nonatomic) IBOutlet UILabel    *audioTimerLabel;

@property (weak, nonatomic) IBOutlet UISwitch   *microphoneSwitch;

@property (nonatomic, strong) EZAudioPlayer         *player;
@property (nonatomic, strong) EZMicrophone          *microphone;
@property (nonatomic, strong) EZRecorder            *recorder;

@property (nonatomic, strong) DPMainEqualizerView   *equalizerView;
@property (strong, nonatomic) ColorSettingsView     *colorSettingsView;
@property (strong, nonatomic) SettingsMenuView      *settingsMenuView;
@property (strong, nonatomic) GeneralSettingsView   *generalSettingsMenuView;

@property (assign, nonatomic) DPEqualizerType   currentType;

@property (strong, nonatomic) NSTimer           *playerTimer;

@end

@implementation PlayRecordViewController

- (void) configureWithEqualizerType : (DPEqualizerType) type {
    self.currentType = type;
}

#pragma mark - Customize the Audio Plot
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_addEqualizerView];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

- (void) p_addEqualizerView {
    DPEqualizerSettings *settings = [DPEqualizerSettings createByType: self.currentType];
    CGRect equalizerViewRect = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 250.f);
    switch (self.currentType) {
        case DPHistogram:
            self.equalizerView = [[DPHistogramEqualizerView alloc] initWithFrame:equalizerViewRect andSettings:settings];
            break;
        case DPRolling:
            self.equalizerView = [[DPRollingEqualizerView alloc] initWithFrame:equalizerViewRect andSettings:settings];
            break;
        case DPRollingWave:
            self.equalizerView = [[DPWaveEqualizerView alloc] initWithFrame:equalizerViewRect andSettings:settings];
            break;
        case DPFillWave:
            self.equalizerView = [[DPWaveEqualizerView alloc] initWithFrame:equalizerViewRect andSettings:settings];
            break;
        case DPWave:
            self.equalizerView = [[DPWaveEqualizerView alloc] initWithFrame:equalizerViewRect andSettings:settings];
            break;
        default:
            equalizerViewRect = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds));
            self.equalizerView = [[DPCircleWaveEqualizer alloc] initWithFrame:equalizerViewRect andSettings:settings];
            break;
    }
    [self.view insertSubview: self.equalizerView belowSubview: self.navigationView];
}


#pragma mark - EZMicrophoneDelegate

- (void)    microphone:(EZMicrophone *)microphone
      hasAudioReceived:(float **)buffer
        withBufferSize:(UInt32)bufferSize
  withNumberOfChannels:(UInt32)numberOfChannels {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.equalizerView) {
            [self.equalizerView updateBuffer: buffer[0] withBufferSize:bufferSize];
        }
    });
}

- (void)microphone:(EZMicrophone *)microphone
     hasBufferList:(AudioBufferList *)bufferList
    withBufferSize:(UInt32)bufferSize
withNumberOfChannels:(UInt32)numberOfChannels {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.recordButton.selected) {
            [self.recorder appendDataFromBufferList:bufferList
                                     withBufferSize:bufferSize];
        }
    });
}


#pragma mark - EZAudioPlayerDelegate

- (void)  audioPlayer:(EZAudioPlayer *)audioPlayer
          playedAudio:(float **)buffer
       withBufferSize:(UInt32)bufferSize
 withNumberOfChannels:(UInt32)numberOfChannels
          inAudioFile:(EZAudioFile *)audioFile {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.player.isPlaying) {
            [self.equalizerView updateBuffer: buffer[0] withBufferSize:bufferSize];
        }
    });
}

/*
 Occurs when the audio player instance completes playback
 */
- (void)audioPlayer:(EZAudioPlayer *)audioPlayer
reachedEndOfAudioFile:(EZAudioFile *)audioFile {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.microphoneSwitch.isOn ? [self p_startMicrophoneFetchingAudio] : [self p_removeAudioPlayer];
    });
}

#pragma mark - Navigation Actions

- (IBAction)backButtonDidTouch:(id)sender {
    [self p_removeAudioPlayer];
    [self closeColorsSettings: nil];
    [self closeSettingsMenuView: nil];
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction)showSettingsMenuButtonDidTouch:(id)sender {
    [self p_setupSettingsMenu];
}

#pragma mark - Button Actions

- (IBAction)pauseButtonDidTouch:(id)sender {
    if (self.player) {
        [self.player pause];
    }
}

- (IBAction)playButtonDidTouch:(id)sender {
    [self p_stopMicrophoneFetchingAudio];
    if (!self.player) {
        [self p_startPlayingAudioFile];
        return;
    }
    if (!self.player.isPlaying) {
        [self.player play];
    }
}

- (IBAction)stopButtonDidTouch:(id)sender {
    [self p_removeAudioPlayer];
}

- (IBAction)microphoneSwitchDidTouch:(UISwitch*)sender {
    [self.microphoneSwitch setOn: sender.isOn];
    self.recordButton.enabled = self.microphoneSwitch.isOn;

    [self p_playerButtonEnable: self.microphoneSwitch.isOn ? ([[NSFileManager defaultManager] fileExistsAtPath: [self p_testAudioRecordPath]]) : !self.microphoneSwitch.isOn];
    
    if (self.microphoneSwitch.isOn) {
        [self p_startMicrophoneFetchingAudio];
    } else {
        [self p_removeAudioPlayer];
        [self p_stopRecord];
        [self p_stopMicrophoneFetchingAudio];
    }
}

- (IBAction) recordButtonDidTouch:(UIButton*)sender {
    [self p_startMicrophoneFetchingAudio];
    self.recordButton.selected = !sender.selected;
    [self p_playerButtonEnable: !self.recordButton.selected];
    self.recordButton.selected ? [self p_createNewRecord] : [self p_stopRecord];
}

#pragma mark - Actions

- (void) p_startPlayingAudioFile {
    if (!self.player) {
        EZAudioFile *audioFile = [[EZAudioFile alloc] initWithURL: self.microphoneSwitch.isOn ? [NSURL fileURLWithPath: [self p_testAudioRecordPath]] : [self p_testAudioFileURL]];
        self.player = [[EZAudioPlayer alloc] initWithAudioFile:audioFile];
        self.player.delegate = self;
        [self.player play];
        if (!self.playerTimer) {
            self.playerTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                                target: self
                                                              selector: @selector(p_updateAudioTimer)
                                                              userInfo: nil
                                                               repeats: YES];
        }
    }
}

- (void) p_removeAudioPlayer {
    if (self.player && self.player.isPlaying) {
        [self.player pause];
    }
    self.player = nil;
    if (self.playerTimer) {
        self.audioTimerLabel.text = @"00:00";
        [self.playerTimer invalidate];
        self.playerTimer = nil;
    }
}

- (void) p_startMicrophoneFetchingAudio {
    [self p_removeAudioPlayer];
    if (!self.microphone) {
        self.microphone = [EZMicrophone microphoneWithDelegate:self];
    }
    [self.microphone startFetchingAudio];
}

- (void) p_stopMicrophoneFetchingAudio {
    if (self.microphone) {
        [self.microphone stopFetchingAudio];
    }
}

- (void) p_createNewRecord {
    self.recorder = [EZRecorder recorderWithURL: [NSURL fileURLWithPath: [self p_testAudioRecordPath]]
                                   clientFormat: self.microphone.audioStreamBasicDescription
                                       fileType: EZRecorderFileTypeM4A];
}

- (void) p_stopRecord {
    if (self.recorder) {
        [self.recorder closeAudioFile];
        self.recorder = nil;
    }
}

- (void) p_playerButtonEnable : (BOOL) enabled {
    self.playButton.enabled = enabled;
    self.pauseButton.enabled = enabled;
    self.stopButton.enabled = enabled;
}


- (void) p_setupSettingsMenu {
    if (!self.settingsMenuView) {
        self.settingsMenuView = [SettingsMenuView createWithSettings: self.equalizerView.equalizerSettings];
        self.settingsMenuView.delegate = self;
        [self.view addSubview: self.settingsMenuView];
        [self.settingsMenuView showWihDuration: 0.245];
    }
}

- (void) p_updateAudioTimer {
    if (self.player.isPlaying) {
        NSInteger ti = self.player.currentTime;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        self.audioTimerLabel.text = [NSString stringWithFormat: @"%0.2ld:%0.2ld", (long)minutes, (long)seconds];
    }
}

- (NSURL*) p_testAudioFileURL {
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource: @"audio2"
                                                              ofType: @"mp3"];
    return [[NSURL alloc] initWithString: audioFilePath];
}

- (NSString*) p_testAudioRecordPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return [NSString stringWithFormat:@"%@/%@", basePath, @"AudioTest.m4a"];
}

#pragma mark - SettingsMenuViewDelegate

- (void) showColorsSettings : (SettingsMenuView*) settingsMenuView settingsMenuItem : (SettingsMenuItem*) settingsMenuItem topCellPoint : (CGPoint) point {
    if (!self.colorSettingsView) {
        self.colorSettingsView = [ColorSettingsView createWithSettings: self.equalizerView.equalizerSettings
                                                                  type: settingsMenuItem.type];
        self.colorSettingsView.frame = CGRectMake(point.x + SCREEN_WIDTH,
                                                  point.y,
                                                  SCREEN_WIDTH - 70.f,
                                                  [self.colorSettingsView height]);
        self.colorSettingsView.delegate = self;
        
        [self.view insertSubview: self.colorSettingsView
                    belowSubview:self.settingsMenuView];
        
        [self.colorSettingsView showFromPoint: point
                                     duration: 0.5];
        return;
    }
    [self.colorSettingsView updateColorSettings: settingsMenuItem.type topPoint: point duration: 0.245];
}

- (void) changeColorsSettings : (SettingsMenuView*) settingsMenuView settingsMenuItem : (SettingsMenuItem*) settingsMenuItem topCellPoint : (CGPoint) point {
    [self.colorSettingsView updateColorSettings: settingsMenuItem.type
                                       topPoint: point
                                       duration: 0.245];
}


- (void) closeColorsSettings : (SettingsMenuView*) settingsMenuView {
    __weak __typeof(&*self)weakSelf = self;
    [self.colorSettingsView closeWithDuration: 0.245
                                   completion:^(BOOL finished)
    {
        [weakSelf.colorSettingsView removeFromSuperview];
        weakSelf.colorSettingsView = nil;
    }];
}


- (void) closeSettingsMenuView : (SettingsMenuView*) settingsMenuView {
    [self closeGeneralSettingsView: nil];
    __weak __typeof(&*self)weakSelf = self;
    [self.settingsMenuView closeWithDuration: 0.245
                                  completion:^(BOOL finished)
    {
        [weakSelf.settingsMenuView removeFromSuperview];
        weakSelf.settingsMenuView = nil;
    }];
}

- (void) showGeneralSettings : (SettingsMenuView*) settingsMenuView {
    if (!self.generalSettingsMenuView) {
        self.generalSettingsMenuView = [GeneralSettingsView createWithSettings: self.equalizerView.equalizerSettings];
        self.generalSettingsMenuView.delegate = self;
        [self.view addSubview: self.generalSettingsMenuView];
        [self.generalSettingsMenuView showWihDuration: 0.5];
        return;
    }
}

- (void) closeGeneralSettings : (SettingsMenuView*) settingsMenuView {
    [self closeGeneralSettingsView: nil];
}

#pragma merk - GeneralSettingsViewDelegate

- (void) updateSettings : (GeneralSettingsMenuItemType) type newValue : (CGFloat) newValue {
    switch (type) {
        case BinsType:
            [self.equalizerView updateNumberOfBins: (int)newValue];
            break;
        case GainType:
            self.equalizerView.equalizerSettings.gain = (int)newValue;
            break;
        case GravityType:
            self.equalizerView.equalizerSettings.gravity = newValue;
            break;
        default:
            break;
    }
}

- (void) closeGeneralSettingsView : (GeneralSettingsView*) generalSettingsView {
    if (!self.generalSettingsMenuView) {
        return;
    }
    if (self.settingsMenuView) {
        [self.settingsMenuView deselectMenuItem];
    }
    __weak __typeof(&*self)weakSelf = self;
    [self.generalSettingsMenuView closeWithDuration: 0.245
                                         completion:^(BOOL finished)
    {
        [weakSelf.generalSettingsMenuView removeFromSuperview];
        weakSelf.generalSettingsMenuView = nil;
    }];
}

#pragma mark - ColorSettingsViewDelegate

- (void) updateColors : (ColorSettingsView*) colorSettingsView {
    [self.equalizerView updateColors];
    [self.settingsMenuView update];
}

@end
