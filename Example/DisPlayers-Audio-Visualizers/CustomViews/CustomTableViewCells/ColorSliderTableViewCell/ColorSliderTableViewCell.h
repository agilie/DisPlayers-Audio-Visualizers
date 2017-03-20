//
//  ColorSliderTableViewCell.h
//  Equalizers
//
//  Created by Michael Liptuga on 14.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainTableViewCell.h"

@class ColorSliderTableViewCell;

@protocol ColorSliderTableViewCellDelegate <NSObject>

- (void) colorSliderTableViewCell : (ColorSliderTableViewCell*) colorSliderTableViewCell colorDidChange : (UIColor*) newColor;

- (void) colorSliderTableViewCell : (ColorSliderTableViewCell*) colorSliderTableViewCell needToAddNewColor : (BOOL) needToAddNewColor;

@end

@interface ColorSliderTableViewCell : MainTableViewCell

@end
