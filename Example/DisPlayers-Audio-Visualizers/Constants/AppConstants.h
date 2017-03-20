//
//  AppConstants.h
//  Equalizers
//
//  Created by Michael Liptuga on 07.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define WSMainScreenSize [UIScreen mainScreen].bounds.size

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


typedef NS_ENUM(NSInteger, SettingsMenuItemType)
{
    CloseSettings,
    EqualizerBackgroundColor,
    EqualizerLowFrequencyColor,
    EqualizerHighFrequencyColor,
    EqualizerBinColor,
    EqualizerGeneralSettings
};

typedef NS_ENUM(NSInteger, GeneralSettingsMenuItemType)
{
    BinsType,
    GainType,
    GravityType
};

FOUNDATION_EXPORT NSString *const segue_showPlayRecordViewController;
