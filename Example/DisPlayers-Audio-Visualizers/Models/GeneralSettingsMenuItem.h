//
//  GeneralSettingsMenuItem.h
//  Equalizers
//
//  Created by Michael Liptuga on 16.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"
#import "DPEqualizerSettings.h"

@interface GeneralSettingsMenuItem : NSObject

@property (nonatomic, strong) DPEqualizerSettings *settings;

@property (nonatomic, assign) GeneralSettingsMenuItemType type;

@property (nonatomic, strong) NSString *cellId;

+ (instancetype) createWithSetiings : (DPEqualizerSettings*) settings
                               type : (GeneralSettingsMenuItemType) type
                             cellId : (NSString*) cellId;

@end
