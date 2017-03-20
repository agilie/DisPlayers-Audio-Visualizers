//
//  DPMainEqualizerView.h
//  Equalizers
//
//  Created by Michael Liptuga on 09.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPEqualizerSettings.h"
#import "DPAudioService.h"

@interface DPMainEqualizerView : UIView

- (instancetype)initWithFrame:(CGRect)frame andSettings : (DPEqualizerSettings*) settings;

- (void)updateBuffer:(float *)buffer withBufferSize:(UInt32)bufferSize;

- (DPAudioService*) audioService;

- (void) setupView;

- (void) updateNumberOfBins : (int) numberOfBins;

- (void) updateColors;

@property (strong, nonatomic) DPEqualizerSettings *equalizerSettings;

@property (nonatomic, strong) UIColor *equalizerBackgroundColor;

@property (nonatomic, strong) UIColor *lowFrequencyColor;

@property (nonatomic, strong) UIColor *hightFrequencyColor;

@property (nonatomic, strong) UIColor *equalizerBinColor;

@end
