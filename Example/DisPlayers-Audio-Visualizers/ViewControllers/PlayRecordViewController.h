//
//  PlayRecordViewController.h
//  Equalizers
//
//  Created by Michael Liptuga on 07.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EZAudio.h"
// Import AVFoundation to play the file (will save EZAudioFile and EZOutput for
// separate example)
#import <AVFoundation/AVFoundation.h>

#import "AppConstants.h"
#import "DPConstants.h"


// By default this will record a file to the application's documents directory
// (within the application's sandbox)

@interface PlayRecordViewController : UIViewController <AVAudioPlayerDelegate>

- (void) configureWithEqualizerType : (DPEqualizerType) type;

/**
 A flag indicating whether we are recording or not
 */
@property (nonatomic, assign) BOOL isRecording;

/**
 The recorder component
 */
//@property (nonatomic, strong) EZRecorder *recorder;

@end
