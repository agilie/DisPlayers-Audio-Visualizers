//
//  GeneralSliderTableViewCell.h
//  Equalizers
//
//  Created by Michael Liptuga on 16.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "MainTableViewCell.h"

@class GeneralSliderTableViewCell;

@protocol GeneralSliderTableViewCellDelegate <NSObject>

- (void) generalSliderTableViewCell : (GeneralSliderTableViewCell*) generalSliderTableViewCell propertyValueChanged : (CGFloat) newValue;

@end

@interface GeneralSliderTableViewCell : MainTableViewCell

@end
