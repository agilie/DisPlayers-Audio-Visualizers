//
//  ColorSettingsView.m
//  Equalizers
//
//  Created by Michael Liptuga on 14.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "ColorSettingsView.h"

#import "ColorSliderTableViewCell.h"

#import "ColorItem.h"

#import "SettingsMenuView.h"

@interface ColorSettingsView () <UITableViewDelegate, UITableViewDataSource, ColorSliderTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *colorSettingsTableView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *gradientSwitch;

@property (nonatomic, strong) DPEqualizerSettings *settings;

@property (nonatomic, assign) SettingsMenuItemType currentType;

@property (nonatomic, strong) NSMutableArray *tableViewData;

@end


@implementation ColorSettingsView

+ (instancetype) createWithSettings : (DPEqualizerSettings*) audioSettings type : (SettingsMenuItemType) type {
    NSString *nibName = NSStringFromClass([self class]);
    NSArray *nibObjects = [[NSBundle mainBundle]loadNibNamed: nibName owner:self options:nil];
    
    ColorSettingsView *colorSettingsView = [nibObjects firstObject];
    colorSettingsView.settings = audioSettings;
    colorSettingsView.currentType = type;
    [colorSettingsView layoutIfNeeded];
    return colorSettingsView;
}

- (CGFloat) height {
    return [ColorSliderTableViewCell heightForCell] * ([self isGradientColor] ? self.tableViewData.count : 1) + 70.f;
}

- (BOOL) isGradientColor {
    return [self colorsByType].count > 1;
}

- (NSMutableArray*) colorsByType {
    switch (self.currentType) {
        case EqualizerBackgroundColor:
            return self.settings.equalizerBackgroundColors;
            break;
        case EqualizerLowFrequencyColor:
            return self.settings.lowFrequencyColors;
            break;
        case EqualizerHighFrequencyColor:
            return self.settings.hightFrequencyColors;
            break;
        case EqualizerBinColor:
            return self.settings.equalizerBinColors;
            break;
        default:
            return [NSMutableArray new];
            break;
    }
}

- (void) updateSettingsColors : (NSArray*) newColors {
        switch (self.currentType) {
            case EqualizerBackgroundColor:
                self.settings.equalizerBackgroundColors = [[NSMutableArray alloc] initWithArray: newColors];
                break;
            case EqualizerLowFrequencyColor:
                 self.settings.lowFrequencyColors = [[NSMutableArray alloc] initWithArray: newColors];
                break;
            case EqualizerHighFrequencyColor:
                 self.settings.hightFrequencyColors = [[NSMutableArray alloc] initWithArray: newColors];
                break;
            case EqualizerBinColor:
                 self.settings.equalizerBinColors = [[NSMutableArray alloc] initWithArray: newColors];
                break;
            default:
                break;
        }
}


- (NSMutableArray*) tableViewData {
    if (!_tableViewData) {
        _tableViewData = [[NSMutableArray alloc] init];
        int colorNumber = [self isGradientColor] ? 4 : 1;
        for (int i = 0; i < colorNumber; i++) {
            if (i < [self colorsByType].count) {
                [_tableViewData addObject: [ColorItem createWithColor: [self colorsByType][i] hidden: NO]];
            } else {
                [_tableViewData addObject: [ColorItem createWithColor: [UIColor lightGrayColor] hidden: YES]];
            }
        }
    }
    return _tableViewData;
}

- (void) show : (UIViewController*) viewController topPoint : (CGPoint) topPoint duration : (CGFloat) duration {
    [UIView animateWithDuration: duration animations:^{
        self.frame = CGRectMake(0, topPoint.y, SCREEN_WIDTH - [SettingsMenuView size].width, [self height]);
        [self p_setupColorSettingsView];
    }];
}

- (void) updateColorSettings : (SettingsMenuItemType) type topPoint : (CGPoint) topPoint duration : (CGFloat) duration {
    self.tableViewData = nil;
    self.currentType = type;
    [UIView animateWithDuration: duration animations:^{
        self.frame = CGRectMake(0, topPoint.y, SCREEN_WIDTH - [SettingsMenuView size].width, [self height]);
        [self p_setupColorSettingsView];
    }];
}

- (void) closeWithDuration : (CGFloat) duration completion : (void (^ __nullable)(BOOL finished)) completion {
    [UIView animateWithDuration: duration animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH, self.frame.origin.y, SCREEN_WIDTH - [SettingsMenuView size].width, [self height]);
    } completion:^(BOOL finished) {
        completion (finished);
    }];
}


#pragma mark - Private actions

- (void) p_setupColorSettingsView {
    [self.gradientSwitch setOn: [self isGradientColor]];
    self.titleLabel.text = [self p_title];
    [self.colorSettingsTableView reloadData];
}

- (NSString*) p_title {
    switch (self.currentType) {
        case EqualizerBackgroundColor:
            return @"Background";
        case EqualizerLowFrequencyColor:
            return @"Low frequency";
        case EqualizerHighFrequencyColor:
            return @"Hight frequency";
        case EqualizerBinColor:
            return @"Frequency";
        default:
            return @"";
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [ColorSliderTableViewCell cellID];
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    if(!cell) {
        cell = [NSClassFromString(identifier) cell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    [cell configurationForObject: self.tableViewData[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ColorSliderTableViewCell heightForCell];
}

#pragma mark - ColorSliderTableViewCellDelegate

- (void) colorSliderTableViewCell : (ColorSliderTableViewCell*) colorSliderTableViewCell colorDidChange : (UIColor*) newColor {
    [self updateColors];
}

- (void) colorSliderTableViewCell : (ColorSliderTableViewCell*) colorSliderTableViewCell needToAddNewColor : (BOOL) needToAddNewColor {
    [self updateColors];
}
#pragma mark - Actions

- (IBAction)gradientSwitchDidTouch:(UISwitch*)sender {
    [self.gradientSwitch setOn: sender.isOn];
    if (self.gradientSwitch.isOn) {
        [[self colorsByType] addObject:[UIColor lightGrayColor]];
        [self updateColorSettings: self.currentType topPoint: self.frame.origin duration: 0.245];
    } else {
        [[self colorsByType] removeObjectsInRange: NSMakeRange(1, [self colorsByType].count - 1)];
        [self updateColorSettings: self.currentType topPoint: self.frame.origin duration: 0.245];
    }
    [self updateColors];
}

- (void) updateColors {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isHidden==%d", NO];
    NSArray *filteredArray = [[self.tableViewData filteredArrayUsingPredicate: predicate] valueForKey: @"color"];
    [self updateSettingsColors: filteredArray];

    if ([self.delegate respondsToSelector:@selector(updateColors:)]) {
        [self.delegate updateColors: self];
    }
}


@end
