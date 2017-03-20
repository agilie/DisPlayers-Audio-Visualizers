//
//  ColorSliderTableViewCell.m
//  Equalizers
//
//  Created by Michael Liptuga on 14.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "ColorSliderTableViewCell.h"

#import "ColorSlider.h"

#import "ColorItem.h"


@interface ColorSliderTableViewCell ()

@property (weak, nonatomic) IBOutlet ColorSlider *colorSlider;

@property (weak, nonatomic) IBOutlet UIView *colorPreview;

@property (weak, nonatomic) IBOutlet UIButton *addNewColorButton;

@property (nonatomic, strong) ColorItem *currentItem;

@end


@implementation ColorSliderTableViewCell

+ (CGFloat) heightForCell {
    return 50.f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.colorPreview.layer.cornerRadius = 6.f;
    self.colorPreview.layer.masksToBounds = YES;
}

- (void) configurationForObject:(ColorItem*)object {
    self.currentItem = object;
    
    self.addNewColorButton.selected = !object.isHidden;
    self.colorSlider.enabled = !object.isHidden;
    
    self.colorSlider.color = object.color;
    self.colorPreview.backgroundColor = object.color;
}

#pragma mark - Actions

- (IBAction) sliderValueDidChange:(ColorSlider*)sender {
    self.colorPreview.backgroundColor = sender.color;
    self.currentItem.color = sender.color;
    
    if ([self.delegate respondsToSelector:@selector(colorSliderTableViewCell:colorDidChange:)]) {
        [self.delegate colorSliderTableViewCell: self colorDidChange: sender.color];
    }
}

#pragma mark - Button Actions

- (IBAction) addNewColorButtonDidTouch:(UIButton*)sender {
    self.addNewColorButton.selected = !sender.selected;
    self.colorSlider.enabled = self.addNewColorButton.selected;
    self.currentItem.isHidden = !self.addNewColorButton.selected;
    self.addNewColorButton.selected ? [self p_addNewColor] : [self p_deleteColor];
}


- (void) p_addNewColor {
    [self sliderValueDidChange: self.colorSlider];
    if ([self.delegate respondsToSelector:@selector(colorSliderTableViewCell:needToAddNewColor:)]) {
        [self.delegate colorSliderTableViewCell: self needToAddNewColor: YES];
    }
}

- (void) p_deleteColor {
    if ([self.delegate respondsToSelector:@selector(colorSliderTableViewCell:needToAddNewColor:)]) {
        [self.delegate colorSliderTableViewCell: self needToAddNewColor: NO];
    }
}

@end
