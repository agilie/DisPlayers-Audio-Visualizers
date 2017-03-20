//
//  SettingsMenuTableViewCell.m
//  Equalizers
//
//  Created by Michael Liptuga on 16.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "SettingsMenuTableViewCell.h"

#import "SettingsMenuItem.h"

@interface SettingsMenuTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation SettingsMenuTableViewCell

- (void) configurationForObject:(SettingsMenuItem*)object {
    switch (object.type) {
        case CloseSettings:
            self.iconImageView.image = [UIImage imageNamed: @"closeSettings_icon"];
            break;
        default:
            self.iconImageView.image = [UIImage imageNamed: @"configEqualizer_icon"];
            break;
    }
}

@end
