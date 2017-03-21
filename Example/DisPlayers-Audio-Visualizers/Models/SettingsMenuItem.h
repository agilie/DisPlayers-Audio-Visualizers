//
//  SettingsMenuItem.h
//  Equalizers
//
//  Created by Michael Liptuga on 14.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"
#import "DPEqualizerSettings.h"

@interface SettingsMenuItem : NSObject

@property (nonatomic, strong) DPEqualizerSettings *settings;

@property (nonatomic, assign) SettingsMenuItemType type;

@property (nonatomic, strong) NSString *cellId;

+ (instancetype) createWithSetiings : (DPEqualizerSettings*) settings
                               type : (SettingsMenuItemType) type
                             cellId : (NSString*) cellId;

@end
