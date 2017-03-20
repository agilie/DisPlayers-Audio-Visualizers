//
//  SettingsMenuView.m
//  Equalizers
//
//  Created by Michael Liptuga on 14.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "SettingsMenuView.h"

#import "SettingsMenuItem.h"

#import "ColorSettingsTableViewCell.h"
#import "SettingsMenuTableViewCell.h"

@interface SettingsMenuView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@property (nonatomic, strong) DPEqualizerSettings *settings;

@property (nonatomic, strong) NSMutableArray *tableViewData;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation SettingsMenuView

+ (instancetype) createWithSettings : (DPEqualizerSettings*) settings {
    NSString *nibName = NSStringFromClass([self class]);
    NSArray *nibObjects = [[NSBundle mainBundle]loadNibNamed: nibName owner:self options:nil];
    
    SettingsMenuView *menu = [nibObjects firstObject];
    menu.settings = settings;
    [menu.menuTableView reloadData];
    
    menu.frame = CGRectMake(SCREEN_WIDTH, 0, [self size].width, [self size].height);
    [menu layoutIfNeeded];
    
    return menu;
}

+ (CGSize) size {
    return CGSizeMake(70, SCREEN_HEIGHT);
}

- (NSMutableArray*) tableViewData {
    if (!_tableViewData) {
        _tableViewData = [[NSMutableArray alloc] init];
        
        [_tableViewData addObject: [SettingsMenuItem createWithSetiings: nil type: CloseSettings cellId: [SettingsMenuTableViewCell cellID]]];
        [_tableViewData addObject: [SettingsMenuItem createWithSetiings: self.settings type: EqualizerBackgroundColor cellId: [ColorSettingsTableViewCell cellID]]];
        if (self.settings.equalizerType == DPWave || self.settings.equalizerType == DPRollingWave || self.settings.equalizerType == DPFillWave) {
            [_tableViewData addObject: [SettingsMenuItem createWithSetiings: self.settings type: EqualizerHighFrequencyColor cellId: [ColorSettingsTableViewCell cellID]]];
            [_tableViewData addObject: [SettingsMenuItem createWithSetiings: self.settings type: EqualizerLowFrequencyColor cellId: [ColorSettingsTableViewCell cellID]]];
        } else {
            [_tableViewData addObject: [SettingsMenuItem createWithSetiings: self.settings type: EqualizerBinColor cellId: [ColorSettingsTableViewCell cellID]]];
        }
        [_tableViewData addObject: [SettingsMenuItem createWithSetiings: nil type: EqualizerGeneralSettings cellId: [SettingsMenuTableViewCell cellID]]];
    }
    return _tableViewData;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsMenuItem *item = self.tableViewData[indexPath.row];
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: item.cellId];
    if(!cell) {
        cell = [NSClassFromString(item.cellId) cell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell configurationForObject: self.tableViewData[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SettingsMenuItem *item = self.tableViewData[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];

    switch (item.type) {
        case CloseSettings:
            [self closeSettingsMenu];
            break;
        case EqualizerGeneralSettings:
            if (self.selectedIndexPath.row == indexPath.row) {
                [self closeGeneralSettings];
                [self deselectMenuItem];
            } else {
                [self deselectMenuItem];
                self.selectedIndexPath = indexPath;
                [self closeColorsSettings: nil];
                [self showGeneralSettings];
                cell.backgroundColor = [UIColor colorWithRed: 62.f/255.f green:62.f/255.f blue:62.f/255.f alpha:1.0];
            }
            break;
        default:
            [self showColorSettings: item tableViewCell: cell];
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.f;
}

#pragma mark - Private Actions

- (void) showColorSettings : (SettingsMenuItem*) item tableViewCell : (UITableViewCell*) tableViewCell {
    NSIndexPath *indexPath = [self.menuTableView indexPathForCell: tableViewCell];
    if (!self.selectedIndexPath || (self.selectedIndexPath.row == self.tableViewData.count - 1)) {
        if (self.selectedIndexPath.row == self.tableViewData.count - 1) {
            [self deselectMenuItem];
            [self closeGeneralSettings];
        }
        self.selectedIndexPath = indexPath;
        tableViewCell.backgroundColor = [UIColor colorWithRed: 62.f/255.f green:62.f/255.f blue:62.f/255.f alpha:1.0];
        [self showColorsSettingsFromPoint: tableViewCell.frame.origin settingsMenuItem: item];
    } else if (self.selectedIndexPath.row == indexPath.row) {
        [self deselectMenuItem];
        [self closeColorsSettings: item];
    } else {
        [self deselectMenuItem];
        tableViewCell.backgroundColor = [UIColor colorWithRed: 62.f/255.f green:62.f/255.f blue:62.f/255.f alpha:1.0];
        self.selectedIndexPath = indexPath;
        [self changeColorsSettings: item topCellPoint:tableViewCell.frame.origin];
    }
}


#pragma mark - Actions

- (void) showWihDuration : (CGFloat) duration {
    [UIView animateWithDuration: duration animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH - [SettingsMenuView size].width, 0, [SettingsMenuView size].width, [SettingsMenuView size].height);
    }];
}

- (void) closeWithDuration : (CGFloat) duration completion : (void (^ __nullable)(BOOL finished)) completion {
    [UIView animateWithDuration: duration animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH, 0, [SettingsMenuView size].width, [SettingsMenuView size].height);
    } completion:^(BOOL finished) {
        completion (finished);
    }];
}

- (void) showColorsSettingsFromPoint : (CGPoint) point settingsMenuItem : (SettingsMenuItem*) settingsMenuItem {
    if ([self.delegate respondsToSelector:@selector(showColorsSettings:settingsMenuItem:topCellPoint:)]) {
        [self.delegate showColorsSettings: self settingsMenuItem : settingsMenuItem topCellPoint: point];
    }
}

- (void) changeColorsSettings : (SettingsMenuItem*) settingsMenuItem topCellPoint : (CGPoint) point {
    if ([self.delegate respondsToSelector:@selector(changeColorsSettings:settingsMenuItem:topCellPoint:)]) {
        [self.delegate changeColorsSettings: self settingsMenuItem : settingsMenuItem topCellPoint: point];
    }
}

- (void) closeColorsSettings: (SettingsMenuItem*) settingsMenuItem{
    if ([self.delegate respondsToSelector:@selector(closeColorsSettings:)]) {
        [self.delegate closeColorsSettings: self];
    }
}

- (void) closeSettingsMenu {
    [self closeColorsSettings: nil];
    if ([self.delegate respondsToSelector:@selector(closeSettingsMenuView:)]) {
        [self.delegate closeSettingsMenuView: self];
    }
}

- (void) showGeneralSettings {
    if ([self.delegate respondsToSelector: @selector(showGeneralSettings:)]) {
        [self.delegate showGeneralSettings: self];
    }
}

- (void) closeGeneralSettings {
    if ([self.delegate respondsToSelector: @selector(closeGeneralSettings:)]) {
        [self.delegate closeGeneralSettings: self];
    }
}

- (void) update {
    [self.menuTableView reloadData];
}

- (void) deselectMenuItem {
    if (self.selectedIndexPath) {
        UITableViewCell *selectedCell = [self.menuTableView cellForRowAtIndexPath: self.selectedIndexPath];
        selectedCell.backgroundColor = [UIColor clearColor];
        self.selectedIndexPath = nil;
    }
}


@end
