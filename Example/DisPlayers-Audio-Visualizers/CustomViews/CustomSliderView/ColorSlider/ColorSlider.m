//
//  ColorSlider.m
//  Equalizers
//
//  Created by Michael Liptuga on 14.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "ColorSlider.h"

@interface ColorSlider ()

@property (nonatomic, strong)UIImageView *colorLineImageView;

@end

@implementation ColorSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initColorSlider];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initColorSlider];
    }
    return self;
}

-(void) initColorSlider {
    UIImage *image = [UIImage imageNamed: @"colorLine"];
    
    self.colorLineImageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview: self.colorLineImageView];
    [self sendSubviewToBack: self.colorLineImageView];
    
    _colorTrackHeight = 4;
    
    [self setMinimumTrackImage:[self imageFromColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [self setMaximumTrackImage:[self imageFromColor:[UIColor clearColor]] forState:UIControlStateNormal];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.colorLineImageView.frame = [self trackRectForBounds:self.bounds];
    CGPoint center = self.colorLineImageView.center;
    CGRect rect = self.colorLineImageView.frame;
    rect.size.height = self.colorTrackHeight;
    self.colorLineImageView.frame = rect;
    self.colorLineImageView.center = center;
    
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch
                     withEvent:(UIEvent *)event{
    BOOL tracking = [super beginTrackingWithTouch:touch withEvent:event];
    return tracking;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    BOOL con = [super continueTrackingWithTouch:touch withEvent:event];
    return con;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event{
    [super cancelTrackingWithEvent:event];
}

-(CGRect)currentThumbRect{
    return [self thumbRectForBounds:self.bounds trackRect:[self trackRectForBounds:self.bounds] value:self.value];
}

-(UIColor *)colorFromCurrentValue{
    return [UIColor colorWithHue: self.value
                      saturation: 1.0
                      brightness: 1.0
                           alpha: 1.0];
}

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)setColor:(UIColor *)color{
    CGFloat hue;
    [color getHue: &hue saturation:nil brightness:nil alpha:nil];
    self.value = hue;
}

-(UIColor *)color{
    return [self colorFromCurrentValue];
}

@end
