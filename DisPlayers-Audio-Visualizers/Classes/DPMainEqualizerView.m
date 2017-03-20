//
//  DPMainEqualizerView.m
//  Equalizers
//
//  Created by Michael Liptuga on 09.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "DPMainEqualizerView.h"

#import "UIImage+DPGradientImage.h"

@interface DPMainEqualizerView () <DPAudioServiceDelegate>

@property (strong, nonatomic) DPAudioService *audioService;

@end

@implementation DPMainEqualizerView

- (instancetype)initWithFrame:(CGRect)frame andSettings : (DPEqualizerSettings*) settings
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.equalizerSettings = settings;
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
}

- (void) setupView {
    self.backgroundColor = self.equalizerBackgroundColor;
}

- (void) updateNumberOfBins : (int) numberOfBins {
    self.audioService.numOfBins = numberOfBins;
    self.equalizerSettings.numOfBins = numberOfBins;
}

- (void) updateColors {
    self.equalizerBackgroundColor = nil;
    self.equalizerBinColor = nil;
    self.lowFrequencyColor = nil;
    self.hightFrequencyColor = nil;
    [self setupView];
}

- (void)updateBuffer:(float *)buffer withBufferSize:(UInt32)bufferSize {
    [self.audioService updateBuffer: buffer withBufferSize: bufferSize];
}

- (DPAudioService*) audioService {
    if (!_audioService) {
        _audioService = [DPAudioService serviceWith: self.equalizerSettings];
        _audioService.delegate = self;
    }
    return _audioService;
}

- (DPEqualizerSettings*) equalizerSettings {
    if (!_equalizerSettings) {
        _equalizerSettings = [DPEqualizerSettings create];
    }
    return _equalizerSettings;
}

- (UIColor*) equalizerBackgroundColor {
    if (!_equalizerBackgroundColor) {
        _equalizerBackgroundColor = (self.equalizerSettings.equalizerBackgroundColors.count > 1) ? [UIColor colorWithPatternImage: [UIImage convertGradientToImage: self.equalizerSettings.equalizerBackgroundColors frame: self.bounds]] : [self.equalizerSettings.equalizerBackgroundColors firstObject];
    }
    return _equalizerBackgroundColor;
}

- (UIColor*) lowFrequencyColor {
    if (!_lowFrequencyColor) {
        _lowFrequencyColor = (self.equalizerSettings.lowFrequencyColors.count > 1) ? [UIColor colorWithPatternImage: [UIImage convertGradientToImage: self.equalizerSettings.lowFrequencyColors frame: self.bounds]] : [self.equalizerSettings.lowFrequencyColors firstObject];
    }
    return _lowFrequencyColor;
}

- (UIColor*) hightFrequencyColor {
    if (!_hightFrequencyColor) {
        _hightFrequencyColor = (self.equalizerSettings.hightFrequencyColors.count > 1) ? [UIColor colorWithPatternImage: [UIImage convertGradientToImage: self.equalizerSettings.hightFrequencyColors frame: self.bounds]] : [self.equalizerSettings.hightFrequencyColors firstObject];
    }
    return _hightFrequencyColor;
}

- (UIColor*) equalizerBinColor {
    if (!_equalizerBinColor) {
        _equalizerBinColor = (self.equalizerSettings.equalizerBinColors.count > 1) ? [UIColor colorWithPatternImage: [UIImage convertGradientToImage: self.equalizerSettings.equalizerBinColors frame: self.bounds]] : [self.equalizerSettings.equalizerBinColors firstObject];
    }
    return _equalizerBinColor;
}

- (void)_refreshDisplay {
#if TARGET_OS_IPHONE
    [self setNeedsDisplay];
#elif TARGET_OS_MAC
    [self setNeedsDisplay:YES];
#endif
}

#pragma mark - DPAudioServiceDelegate

- (void) refreshEqualizerDisplay {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self _refreshDisplay];
    });
}

@end
