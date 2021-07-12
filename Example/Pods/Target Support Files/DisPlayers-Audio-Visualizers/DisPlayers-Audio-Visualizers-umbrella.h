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

#import "DPAudioService.h"
#import "DPCircleWaveEqualizer.h"
#import "DPConstants.h"
#import "DPEqualizerSettings.h"
#import "DPHistogramEqualizerView.h"
#import "DPMainEqualizerView.h"
#import "DPRollingEqualizerView.h"
#import "DPWaveEqualizerView.h"
#import "UIImage+DPGradientImage.h"

FOUNDATION_EXPORT double DisPlayers_Audio_VisualizersVersionNumber;
FOUNDATION_EXPORT const unsigned char DisPlayers_Audio_VisualizersVersionString[];

