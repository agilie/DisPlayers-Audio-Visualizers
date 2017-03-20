//
//  EqualizerTypeListTableViewCell.m
//  Equalizers
//
//  Created by Michael Liptuga on 09.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "EqualizerTypeListTableViewCell.h"
#import "Equalizer.h"

@interface EqualizerTypeListTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *equalizerNameLabel;

@end

@implementation EqualizerTypeListTableViewCell

- (void) configurationForObject:(Equalizer*)object {
    self.equalizerNameLabel.text = object.name;
}

@end
