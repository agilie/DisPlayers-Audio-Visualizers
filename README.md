# DisPlayers-Audio-Visualizers

[![CI Status](http://img.shields.io/travis/agilie/DisPlayers-Audio-Visualizers.svg?style=flat)](https://travis-ci.org/liptugamichael@gmail.com/DisPlayers-Audio-Visualizers)
[![Version](https://img.shields.io/cocoapods/v/DisPlayers-Audio-Visualizers.svg?style=flat)](http://cocoapods.org/pods/DisPlayers-Audio-Visualizers)
[![License](https://img.shields.io/cocoapods/l/DisPlayers-Audio-Visualizers.svg?style=flat)](http://cocoapods.org/pods/DisPlayers-Audio-Visualizers)
[![Platform](https://img.shields.io/cocoapods/p/DisPlayers-Audio-Visualizers.svg?style=flat)](http://cocoapods.org/pods/DisPlayers-Audio-Visualizers)

# DisPlayers-Audio-Visualizers
DisPlayer is a customizable audio visualization component that works with recording and playing back audio files

<img src="https://cloud.githubusercontent.com/assets/11332192/24103061/c3197d9c-0d86-11e7-8563-335eb32e7a75.gif" alt="Histogram Demo" height="375" width="215" border ="50">   <img src="https://cloud.githubusercontent.com/assets/11332192/24104739/9e551c0a-0d8b-11e7-8c08-1c3663db1065.gif" alt="Rolling Demo" height="375" width="215">
<img src="https://cloud.githubusercontent.com/assets/11332192/24104119/0ad9faaa-0d8a-11e7-9889-31f5df7a8648.gif" alt="Wave Dem" height="375" width="215">   <img src="https://cloud.githubusercontent.com/assets/11332192/24104353/b4151578-0d8a-11e7-95f1-d267fab0ac49.gif" alt="WaveStroke Dem" height="375" width="215">

The audio visualizer can be easily embedded into an app that features:
* audio comments to text or multimedia posts
* recording and sending audio files in a chat
* playing back audio files posted in a chat using a dedicated UI component

DisPlayer features 5 default visualization presets that can be customized by the background color (single tone or gradient), the wave color, the number of the wave’s bins/bars, and the wave amplitude.

## Installation

The control can be easily embedded into an app:

### [CocoaPods](https://cocoapods.org/) (recommended)

````ruby
# For latest release in cocoapods
pod 'DisPlayers-Audio-Visualizers', '~> 0.1.1'
````

## Getting started

*Getting started guide for DisPlayers-Audio-Visualizers*
1) You should added next classes into your project:

 ````objective-c
#import "EZAudio.h" 
#import "DPMainEqualizerView.h"
#import "DPEqualizerSettings.h"
````

2) This library contains four types of equalizer visualisation: (Histogram, Rolling, Wave and Circle Wave). And you should chose want kind of equalizer visualization you want and import that class into your project.

### Histogram initialization example:

````objective-c
    DPEqualizerSettings *settings = [DPEqualizerSettings createByType: DPHistogram];
    self.equalizerView = [[DPHistogramEqualizerView alloc] initWithFrame: self.view.bounds 
                                                             andSettings: settings];
    [self.view addSubview: self.equalizerView];
````

````objective-c
     NSString *audioPath = [[NSBundle mainBundle] pathForResource: @"YOUR_AUDIO_FILE_PATH" 
                                                           ofType: @"AUDIO_FILE_TYPE"];
     EZAudioFile *audioFile = [[EZAudioFile alloc] initWithURL: [[NSURL alloc] initWithString: audioPath]];
     self.player = [[EZAudioPlayer alloc] initWithAudioFile: audioFile];
     self.player.delegate = self;
     [self.player play];
````

EZAudioPlayerDelegate

````objective-c
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
````

3) You can also customize equalizer visualisation. You can change default settings for all equalizer visualisation types:
````objective-c
/// The highest bound of the frequency. Default: 7000Hz
@property (nonatomic) float maxFrequency;

/// The lowest bound of the frequency. Default: 400Hz
@property (nonatomic) float minFrequency;

/// The number of bins in the audio plot. Default: 40
@property (nonatomic) NSUInteger numOfBins;

/// The padding of each bin in percent width. Default: 0.2
@property (nonatomic) CGFloat padding;

/// The gain applied to the height of each bin. Default: 10
@property (nonatomic) CGFloat gain;

/// A float that specifies the vertical gravitational acceleration applied to each bin.
/// Default: 10 pixel/sec^2
@property (nonatomic) float gravity;

/// The number of max bin height. Default: Screen height.
@property (assign, nonatomic) CGFloat maxBinHeight;

/// The type of plot that can be displayed in the view using the data. Default: DPPlotTypeBuffer.
@property (assign, nonatomic) DPPlotType plotType;

/// The type of equalizer that can be displayed in the view using the data. Default: DPHistogram.
@property (assign, nonatomic) DPEqualizerType equalizerType;

/// The colors of equalizer background that can be displayed in the view.
@property (nonatomic, strong) NSMutableArray *equalizerBackgroundColors;

/// The colors of low frequency that can be displayed in the view.
@property (nonatomic, strong) NSMutableArray *lowFrequencyColors;

/// The colors of hight frequency that can be displayed in the view.
@property (nonatomic, strong) NSMutableArray *hightFrequencyColors;

/// The colors of bins that can be displayed in the view.
@property (nonatomic, strong) NSMutableArray *equalizerBinColors;

@property (nonatomic, assign) BOOL fillGraph;
````

Some presets display audio frequencies as a separate waves, which provides more possibilities for cool sound visualization for your project.

## Usage

CocoaPods is the recommended way to add DisPlayer to your project:
 
 1. Add a pod entry for DisPlayer to your Podfile pod 'DisPlayer'
 2. Install the pod(s) by running pod installation.
 3. Include DisPlayer wherever you need it with #import «Equalizers.h».

## Requirements

DisPlayer works on iOS 8.0+ and is compatible with ARC projects.
It depends on the following Apple frameworks, which should already be included with most Xcode templates:
CoreGraphics.framework
QuartzCore.framework 
CoreAudio.framework 
You will need LLVM 3.0 or later in order to build “DisPlayer”

## Author

This library is open-sourced by  [Agilie Team](https://www.agilie.com) <info@agilie.com>

## Contributors

[Michael Liptuga](https://github.com/Liptuga-Michael) - <michael.liptuga@agilie.com>


## Contact us

<ios@agilie.com>


## License

The [MIT](LICENSE.MD) License (MIT) Copyright © 2017 [Agilie Team](https://www.agilie.com)
