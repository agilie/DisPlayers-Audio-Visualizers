//
//  ColorItem.h
//  Equalizers
//
//  Created by Michael Liptuga on 15.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorItem : NSObject

+ (instancetype) createWithColor : (UIColor*) color hidden : (BOOL) hidden;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL isHidden;

@end
