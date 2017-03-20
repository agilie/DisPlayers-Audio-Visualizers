//
//  ColorItem.m
//  Equalizers
//
//  Created by Michael Liptuga on 15.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "ColorItem.h"

@implementation ColorItem

+ (instancetype) createWithColor : (UIColor*) color hidden : (BOOL) hidden {
    ColorItem *item = [[ColorItem alloc] init];
    
    item.color = color;
    item.isHidden = hidden;
    
    return item;
}


@end
