//
//  GeneralSliderTableViewCell.m
//  Equalizers
//
//  Created by Michael Liptuga on 16.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "GeneralSliderTableViewCell.h"

#import "GeneralSettingsSlider.h"

#import "GeneralSettingsMenuItem.h"

@interface GeneralSliderTableViewCell ()

@property (weak, nonatomic) IBOutlet GeneralSettingsSlider *slider;

@property (weak, nonatomic) IBOutlet UILabel *propertyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *propertyValueLabel;

@property (nonatomic, strong) GeneralSettingsMenuItem *currentItem;
@end

@implementation GeneralSliderTableViewCell

+ (CGFloat)heightForCell {
    return 86.f;
}

- (void) configurationForObject:(GeneralSettingsMenuItem*)object {
    self.currentItem = object;
    
    self.slider.maximumValue = [self p_maximumSliderValue];
    self.slider.minimumValue = [self p_minimumSliderValue];
    self.slider.value = [self p_currentSliderValue];
    
    self.propertyNameLabel.text = [self p_propertyNameLabelText];
    self.propertyValueLabel.text = [self p_propertyValueLabelText];
}

#pragma mark - Private methods

- (CGFloat) p_currentSliderValue {
    switch (self.currentItem.type) {
        case BinsType:
            return self.currentItem.settings.numOfBins;
            break;
        case GainType:
            return self.currentItem.settings.gain;
            break;
        default:
            return self.currentItem.settings.gravity;
            break;
    }
}

-(NSString*) p_propertyNameLabelText {
    switch (self.currentItem.type) {
        case BinsType:
            return @"Bins";
            break;
        case GainType:
            return @"Gain";
            break;
        default:
            return @"Gravity";
            break;
    }
}

- (NSString*) p_propertyValueLabelText {
    switch (self.currentItem.type) {
        case BinsType:
            return [NSString stringWithFormat: @"%.0f", self.slider.value];
            break;
        default:
            return [NSString stringWithFormat: @"%.2f", self.slider.value];
            break;
    }
}

-(CGFloat) p_maximumSliderValue {
    switch (self.currentItem.type) {
        case BinsType:
            return 300;
            break;
        case GainType:
            return 20;
            break;
        default:
            return 10;
            break;
    }
}

-(CGFloat) p_minimumSliderValue {
    switch (self.currentItem.type) {
        case BinsType:
            return 20;
            break;
        case GainType:
            return 1;
            break;
        default:
            return 0.01;
            break;
    }
}

#pragma mark - Actions

- (IBAction) sliderValueDidChange: (GeneralSettingsSlider*)sender {
    self.propertyValueLabel.text = [self p_propertyValueLabelText];
    if ([self.delegate respondsToSelector:@selector(generalSliderTableViewCell:propertyValueChanged:)]) {
        [self.delegate generalSliderTableViewCell: self propertyValueChanged: sender.value];
    }
}

@end
