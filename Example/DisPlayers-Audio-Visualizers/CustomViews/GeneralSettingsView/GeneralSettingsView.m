//
//  GeneralSettingsView.m
//  Equalizers
//
//  Created by Michael Liptuga on 16.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "GeneralSettingsView.h"

#import "GeneralSliderTableViewCell.h"

#import "GeneralSettingsMenuItem.h"

#import "SettingsMenuView.h"

@interface GeneralSettingsView () <UITableViewDataSource, UITableViewDelegate, GeneralSliderTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (nonatomic, strong) DPEqualizerSettings *settings;

@property (nonatomic, strong) NSMutableArray *tableViewData;

@end

@implementation GeneralSettingsView

+ (instancetype) createWithSettings : (DPEqualizerSettings*) settings {
    NSString *nibName = NSStringFromClass([self class]);
    NSArray *nibObjects = [[NSBundle mainBundle]loadNibNamed: nibName owner:self options:nil];
    
    GeneralSettingsView *menu = [nibObjects firstObject];
    menu.settings = settings;
    [menu.settingsTableView reloadData];
    
    menu.frame = CGRectMake(0, SCREEN_HEIGHT, [menu size].width, [menu size].height);
    [menu layoutIfNeeded];
    
    return menu;
}

- (CGSize) size {
    return CGSizeMake(SCREEN_WIDTH - [SettingsMenuView size].width, self.tableViewData.count * [GeneralSliderTableViewCell heightForCell] + CGRectGetHeight(self.doneButton.frame));
}

- (NSMutableArray*) tableViewData {
    if (!_tableViewData) {
        _tableViewData = [[NSMutableArray alloc] init];
        [_tableViewData addObject: [GeneralSettingsMenuItem createWithSetiings: self.settings type: BinsType cellId: [GeneralSliderTableViewCell cellID]]];
        [_tableViewData addObject: [GeneralSettingsMenuItem createWithSetiings: self.settings type: GainType cellId: [GeneralSliderTableViewCell cellID]]];
        [_tableViewData addObject: [GeneralSettingsMenuItem createWithSetiings: self.settings type: GravityType cellId: [GeneralSliderTableViewCell cellID]]];
    }
    return _tableViewData;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GeneralSettingsMenuItem *item = self.tableViewData[indexPath.row];
    
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: item.cellId];
    if(!cell) {
        cell = [NSClassFromString(item.cellId) cell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    [cell configurationForObject: self.tableViewData[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [GeneralSliderTableViewCell heightForCell];
}

#pragma mark - Actions

- (void) showWihDuration : (CGFloat) duration {
    [UIView animateWithDuration: duration animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT - [self size].height, [self size].width, [self size].height);
    }];
}

- (void) closeWithDuration : (CGFloat) duration completion : (void (^)(BOOL finished)) completion {
    [UIView animateWithDuration: duration animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, [self size].width, [self size].height);
    } completion:^(BOOL finished) {
        completion (finished);
    }];
}

- (IBAction)doneButtonDidTouch:(id)sender {
    if ([self.delegate respondsToSelector:@selector(closeGeneralSettingsView:)]) {
        [self.delegate closeGeneralSettingsView: self];
    }
}

#pragma mark - 

- (void) generalSliderTableViewCell : (GeneralSliderTableViewCell*) generalSliderTableViewCell propertyValueChanged : (CGFloat) newValue {
    NSIndexPath *indexPath = [self.settingsTableView indexPathForCell: generalSliderTableViewCell];
    GeneralSettingsMenuItem *item = self.tableViewData[indexPath.row];

    if ([self.delegate respondsToSelector:@selector(updateSettings:newValue:)]) {
        [self.delegate updateSettings: item.type  newValue: newValue];
    }
}


@end
