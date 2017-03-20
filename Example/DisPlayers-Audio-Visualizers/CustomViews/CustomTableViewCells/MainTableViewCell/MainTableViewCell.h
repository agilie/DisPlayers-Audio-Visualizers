//
//  MainTableViewCell.h
//  Equalizers
//
//  Created by Michael Liptuga on 09.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell

@property (nonatomic, weak) id delegate;

+ (NSString*) cellID;
+ (CGFloat) heightForCell;

+ (instancetype) cell;
+ (id) cellNib;

- (void) configurationForObject:(id)object;

@end
