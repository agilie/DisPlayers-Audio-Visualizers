//
//  ColorSettingsTableViewCell.m
//  Equalizers
//
//  Created by Michael Liptuga on 14.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "ColorSettingsTableViewCell.h"
#import "SettingsMenuItem.h"

#import "UIImage+DPGradientImage.h"

@interface ColorSettingsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *chosenColorImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chosenColorImageViewHeightConstraint;

@property (nonatomic, strong) SettingsMenuItem* currentMenuItem;

@end

@implementation ColorSettingsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.chosenColorImageView.layer.cornerRadius = 6.f;
    self.chosenColorImageView.layer.masksToBounds = YES;
}

- (void) configurationForObject: (SettingsMenuItem*) object {
    self.currentMenuItem = object;
    [self p_configureChosenColorImageView: [self p_colorsByItemType] isGradientColor: [self p_colorsByItemType].count > 1];
}

- (NSMutableArray*) p_colorsByItemType {
    switch (self.currentMenuItem.type) {
        case EqualizerBackgroundColor:
            return self.currentMenuItem.settings.equalizerBackgroundColors;
            break;
        case EqualizerLowFrequencyColor:
            return self.currentMenuItem.settings.lowFrequencyColors;
            break;
        case EqualizerHighFrequencyColor:
            return self.currentMenuItem.settings.hightFrequencyColors;
            break;
        default:
            return self.currentMenuItem.settings.equalizerBinColors;
            break;
    }
}

- (void) p_configureChosenColorImageView: (NSMutableArray*) colors isGradientColor: (BOOL) isGradientColor  {
    [self layoutIfNeeded];
    self.chosenColorImageViewHeightConstraint.constant = isGradientColor ? 40 : 20;
    __weak __typeof(&*self)weakSelf = self;
    
    [UIView animateWithDuration: 0.145
                     animations:^
    {
        [weakSelf layoutIfNeeded];
    }
                     completion:^(BOOL finished)
    {
        if (isGradientColor) {
            UIImage *image = [UIImage convertGradientToImage: colors frame: weakSelf.chosenColorImageView.frame];
            weakSelf.chosenColorImageView.backgroundColor = [UIColor colorWithPatternImage: image];
            return;
        }
        weakSelf.chosenColorImageView.backgroundColor = [colors firstObject];
    }];
}


@end
