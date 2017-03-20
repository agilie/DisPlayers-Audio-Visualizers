//
//  MainTableViewCell.m
//  Equalizers
//
//  Created by Michael Liptuga on 09.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

+ (NSString*) cellID {
    return NSStringFromClass([self class]);
}

+ (CGFloat)heightForCell {
    return 44.f;
}

+ (instancetype) cell {
    NSArray* nibArray = [[NSBundle mainBundle]loadNibNamed:[self cellID] owner:nil options:nil];
    return [nibArray firstObject];
}

+ (id) cellNib {
    return [self cell];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configurationForObject:(id)object {
    
}

@end
