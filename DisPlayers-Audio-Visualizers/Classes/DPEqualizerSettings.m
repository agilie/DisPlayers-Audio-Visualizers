//
//  AudioSettings.m
//  Equalizers
//
//  Created by Michael Liptuga on 07.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "DPEqualizerSettings.h"

@implementation DPEqualizerSettings

+ (instancetype) create {
    DPEqualizerSettings *audioSettings = [[DPEqualizerSettings alloc] init];
    
    audioSettings.maxFrequency = 7000; //
    audioSettings.minFrequency = 400; //
    audioSettings.numOfBins = 40; //
    audioSettings.padding = 2 / 10.0; //
    audioSettings.gain = 10; //
    audioSettings.gravity = 10; ///
    
    audioSettings.maxBinHeight = [UIScreen mainScreen].bounds.size.height;
    audioSettings.plotType = DPPlotTypeBuffer;
    audioSettings.equalizerType = DPHistogram;
    
    audioSettings.equalizerBinColors = [[NSMutableArray alloc] initWithObjects:[UIColor blueColor], nil];
    audioSettings.lowFrequencyColors = [[NSMutableArray alloc] initWithObjects:[UIColor greenColor], nil];
    audioSettings.hightFrequencyColors = [[NSMutableArray alloc] initWithObjects:[UIColor purpleColor], nil];
    audioSettings.equalizerBackgroundColors = [[NSMutableArray alloc] initWithObjects:[UIColor whiteColor], nil];

    return audioSettings;
}

+ (instancetype) createByType : (DPEqualizerType) type {
    switch (type) {
        case DPHistogram:
            return [self createHistogramAudioSettings];
        case DPRolling:
            return [self createRollingAudioSettings];
        case DPRollingWave:
            return [self createRollingWaveAudioSettings];
        case DPFillWave:
            return [self createFillWaveAudioSettings];
        case DPWave:
            return [self createWaveAudioSettings];
        default:
            return [self createCircleWaveAudioSettings];
    }
}


+ (instancetype) createHistogramAudioSettings {
    DPEqualizerSettings *audioSettings = [DPEqualizerSettings create];
    
        audioSettings.equalizerType = DPHistogram;
        audioSettings.numOfBins = 30;
        audioSettings.gravity = 3;
        audioSettings.plotType = DPPlotTypeBuffer;
        audioSettings.padding = 0.3;
    
    UIColor *firstColor = [UIColor colorWithRed: 87.0/255.0
                                          green: 109.0/255.0
                                           blue: 255.0/255.0
                                          alpha: 1.0];
    
    UIColor *secondColor = [UIColor colorWithRed: 245.0/255.0
                                           green: 240.0/255.0
                                            blue: 255.0/255.0
                                           alpha: 1.0];
    
        audioSettings.equalizerBinColors = [[NSMutableArray alloc] initWithObjects: firstColor, secondColor, nil];
        audioSettings.equalizerBackgroundColors = [[NSMutableArray alloc] initWithObjects: [UIColor whiteColor], nil];

    return audioSettings;
}

+ (instancetype) createRollingAudioSettings {
    DPEqualizerSettings *audioSettings = [DPEqualizerSettings create];
    
        audioSettings.equalizerType = DPRolling;
        audioSettings.numOfBins = 50;
        audioSettings.plotType = DPPlotTypeRolling;
        audioSettings.padding = 0.3;

        audioSettings.equalizerBackgroundColors = [[NSMutableArray alloc] initWithObjects: [UIColor colorWithRed: 36.0/255.0 green: 41.0/255.0 blue: 50.0/255.0 alpha: 1.0], nil];
        audioSettings.equalizerBinColors = [[NSMutableArray alloc] initWithObjects: [UIColor colorWithRed: 255.0/255.0  green: 219.0/255.0 blue: 114.0/255.0 alpha:1.0], nil];
    
    return audioSettings;

}

+ (instancetype) createRollingWaveAudioSettings {
    DPEqualizerSettings *audioSettings = [DPEqualizerSettings create];
    
        audioSettings.equalizerType = DPRollingWave;
        audioSettings.numOfBins = 50;
        audioSettings.plotType = DPPlotTypeRolling;
        audioSettings.fillGraph = YES;
    
    UIColor *firstColor = [UIColor colorWithRed: 194.0/255.0
                                          green: 207.0/255.0
                                           blue: 255.0/255.0
                                          alpha:1.0];
    
    UIColor *secondColor = [UIColor colorWithRed: 255.0/255.0
                                           green: 160.0/255.0
                                            blue: 143.0/255.0
                                           alpha:1.0];

    audioSettings.lowFrequencyColors = [[NSMutableArray alloc] initWithObjects: firstColor, nil];
    audioSettings.hightFrequencyColors = [[NSMutableArray alloc] initWithObjects: secondColor, nil];
    audioSettings.equalizerBackgroundColors = [[NSMutableArray alloc] initWithObjects:[UIColor whiteColor], nil];
    
    return audioSettings;

}

+ (instancetype) createFillWaveAudioSettings {
    DPEqualizerSettings *audioSettings = [DPEqualizerSettings create];
    
    audioSettings.equalizerType = DPFillWave;
    audioSettings.numOfBins = 50;
    audioSettings.gravity = 3;
    audioSettings.plotType = DPPlotTypeBuffer;
    audioSettings.fillGraph = YES;
    
    UIColor *firstColor = [UIColor colorWithRed: 194.0/255.0
                                          green: 207.0/255.0
                                           blue: 255.0/255.0
                                          alpha: 1.0];
    
    UIColor *secondColor = [UIColor colorWithRed: 255.0/255.0
                                           green: 160.0/255.0
                                            blue: 143.0/255.0
                                           alpha: 1.0];
    
    audioSettings.lowFrequencyColors = [[NSMutableArray alloc] initWithObjects: firstColor, nil];
    audioSettings.hightFrequencyColors = [[NSMutableArray alloc] initWithObjects: secondColor, nil];

    audioSettings.equalizerBackgroundColors = [[NSMutableArray alloc] initWithObjects:[UIColor whiteColor], nil];
    
    return audioSettings;

}

+ (instancetype) createWaveAudioSettings {
    DPEqualizerSettings *audioSettings = [DPEqualizerSettings create];
    
    audioSettings.equalizerType = DPWave;
    audioSettings.numOfBins = 50;
    audioSettings.gravity = 3;
    audioSettings.plotType = DPPlotTypeBuffer;
    audioSettings.fillGraph = NO;
    
    audioSettings.equalizerBackgroundColors = [[NSMutableArray alloc] initWithObjects: [UIColor whiteColor], nil];
    
    audioSettings.lowFrequencyColors = [[NSMutableArray alloc] initWithObjects:[UIColor colorWithRed: 255/255.0  green: 134/255.0 blue: 134/255.0 alpha:1.0], nil];
    audioSettings.hightFrequencyColors = [[NSMutableArray alloc] initWithObjects:[UIColor colorWithRed: 255/255.0  green: 134/255.0 blue: 134/255.0 alpha:1.0], nil];
    
    return audioSettings;

}

+ (instancetype) createCircleWaveAudioSettings {
    DPEqualizerSettings *audioSettings = [DPEqualizerSettings create];
    
        audioSettings.equalizerType = DPCircleWave;
        audioSettings.numOfBins = 180;
        audioSettings.padding = 0.5;
        audioSettings.maxFrequency = 4400;
        audioSettings.gravity = 2;
        audioSettings.plotType = DPPlotTypeBuffer;
        audioSettings.fillGraph = YES;
    
    UIColor *firstColor = [UIColor colorWithRed: 87.0/255.0
                                          green: 109/255.0
                                           blue: 255.0/255.0
                                          alpha: 1.0];
    
    UIColor *secondColor = [UIColor colorWithRed: 255.0/255.0
                                           green: 160.0/255.0
                                            blue: 143.0/255.0
                                           alpha: 1.0];
    
        audioSettings.equalizerBackgroundColors = [[NSMutableArray alloc] initWithObjects: [UIColor whiteColor], nil];
        audioSettings.equalizerBinColors = [[NSMutableArray alloc] initWithObjects: firstColor, secondColor, firstColor, nil];
    
    return audioSettings;

}

@end
