//
//  SettingsMenuView.h
//  Equalizers
//
//  Created by Michael Liptuga on 14.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DPEqualizerSettings.h"
#import "SettingsMenuItem.h"

@class SettingsMenuView;

@protocol SettingsMenuViewDelegate <NSObject>

@optional

- (void) showColorsSettings : (SettingsMenuView*) settingsMenuView settingsMenuItem : (SettingsMenuItem*) settingsMenuItem topCellPoint : (CGPoint) point ;

- (void) changeColorsSettings : (SettingsMenuView*) settingsMenuView settingsMenuItem : (SettingsMenuItem*) settingsMenuItem topCellPoint : (CGPoint) point ;

- (void) closeColorsSettings : (SettingsMenuView*) settingsMenuView;

- (void) closeSettingsMenuView : (SettingsMenuView*) settingsMenuView;

- (void) showGeneralSettings : (SettingsMenuView*) settingsMenuView;

- (void) closeGeneralSettings : (SettingsMenuView*) settingsMenuView;

@end


@interface SettingsMenuView : UIView

+ (instancetype) createWithSettings : (DPEqualizerSettings*) settings;

+ (CGSize) size;

- (void) update;

- (void) deselectMenuItem;

- (void) showWihDuration : (CGFloat) duration;

- (void) closeWithDuration : (CGFloat) duration
                completion : (void (^)(BOOL finished)) completion;

@property (nonatomic, weak) id<SettingsMenuViewDelegate> delegate;

@end
