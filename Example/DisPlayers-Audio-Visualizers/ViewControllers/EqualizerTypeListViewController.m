//
//  EqualizerTypeListViewController.m
//  Equalizers
//
//  Created by Michael Liptuga on 09.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "EqualizerTypeListViewController.h"

//Models
#import "Equalizer.h"

//CustomViews
#import "EqualizerTypeListTableViewCell.h"
#import "MainTableViewCell.h"

//ViewControllers
#import "PlayRecordViewController.h"

@interface EqualizerTypeListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tableViewData;

@end

@implementation EqualizerTypeListViewController

- (NSMutableArray*) tableViewData {
    if (!_tableViewData) {
        _tableViewData = [[NSMutableArray alloc] init];
        [_tableViewData addObject:[Equalizer createWithType: DPHistogram name: @"Histogram example"]];
        [_tableViewData addObject:[Equalizer createWithType: DPRolling name: @"Rolling example"]];
        [_tableViewData addObject:[Equalizer createWithType: DPRollingWave name: @"Rolling wave example"]];
        [_tableViewData addObject:[Equalizer createWithType: DPFillWave name: @"Wave example with fill graph"]];
        [_tableViewData addObject:[Equalizer createWithType: DPWave name: @"Wave example"]];
        [_tableViewData addObject:[Equalizer createWithType: DPCircleWave name: @"Circle Wave example"]];
    }
    return _tableViewData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 20, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableViewData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [EqualizerTypeListTableViewCell cellID];
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [NSClassFromString(cellIdentifier) cell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    id currentObject = self.tableViewData[indexPath.row];
    [cell configurationForObject: currentObject];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Equalizer *currentEqualizer = self.tableViewData[indexPath.row];
    [self performSegueWithIdentifier: segue_showPlayRecordViewController sender: currentEqualizer];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: segue_showPlayRecordViewController]) {
        PlayRecordViewController *playRecordViewController = segue.destinationViewController;
        if ([sender isKindOfClass:[Equalizer class]]) {
            Equalizer *equalizer = (Equalizer*) sender;
            [playRecordViewController configureWithEqualizerType : equalizer.type];
        }
    }
}

@end
