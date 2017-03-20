//
//  GeneralSettingsSlider.m
//  Equalizers
//
//  Created by Michael Liptuga on 16.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "GeneralSettingsSlider.h"

@implementation GeneralSettingsSlider

- (CGRect) trackRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 5);
}

@end
