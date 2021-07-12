#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "EZAudio.h"
#import "EZAudioDevice.h"
#import "EZAudioDisplayLink.h"
#import "EZAudioFFT.h"
#import "EZAudioFile.h"
#import "EZAudioFloatConverter.h"
#import "EZAudioFloatData.h"
#import "EZAudioiOS.h"
#import "EZAudioOSX.h"
#import "EZAudioPlayer.h"
#import "EZAudioPlot.h"
#import "EZAudioPlotGL.h"
#import "EZAudioUtilities.h"
#import "EZMicrophone.h"
#import "EZOutput.h"
#import "EZPlot.h"
#import "EZRecorder.h"
#import "TPCircularBuffer.h"

FOUNDATION_EXPORT double EZAudioVersionNumber;
FOUNDATION_EXPORT const unsigned char EZAudioVersionString[];

