//
//  ColorSettingsView.h
//  Equalizers
//
//  Created by Michael Liptuga on 14.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DPEqualizerSettings.h"

#import "AppConstants.h"

@class ColorSettingsView;

@protocol ColorSettingsViewDelegate <NSObject>

- (void) updateColors : (ColorSettingsView*) colorSettingsView;

@end

@interface ColorSettingsView : UIView

@property (nonatomic, weak) id<ColorSettingsViewDelegate> delegate;

+ (instancetype) createWithSettings : (DPEqualizerSettings*) audioSettings type : (SettingsMenuItemType) type;

- (CGFloat) height;

- (void) show : (UIViewController*) viewController topPoint : (CGPoint) topPoint duration : (CGFloat) duration;

- (void) updateColorSettings : (SettingsMenuItemType) type topPoint : (CGPoint) topPoint duration : (CGFloat) duration;

- (void) closeWithDuration : (CGFloat) duration completion : (void (^)(BOOL finished)) completion;

@end
