//
//  DPConstants.h
//  Equalizers
//
//  Created by Michael Liptuga on 17.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

typedef NS_ENUM(NSInteger, DPPlotType)
{
    /**
     Plot that displays only the samples of the current buffer
     */
    DPPlotTypeBuffer,
    /**
     Plot that displays a rolling history of values using the RMS calculated for each incoming buffer
     */
    DPPlotTypeRolling
};


typedef NS_ENUM(NSInteger, DPEqualizerType)
{
    /**
     Histogram equalizer type
     */
    DPHistogram,
    /**
     Rolling equalizer type
     */
    DPRolling,
    /**
     Rolling wave equalizer type with fill
     */
    DPRollingWave,
    /**
     Wave equalizer type with fill
     */
    DPFillWave,
    /**
     Wave equalizer type
     */
    DPWave,
    /**
     Circle wave equalizer type with fill
     */
    DPCircleWave
};
