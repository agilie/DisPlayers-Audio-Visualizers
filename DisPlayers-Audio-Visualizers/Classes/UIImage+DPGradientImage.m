//
//  UIImage+GradientImage.m
//  Equalizers
//
//  Created by Michael Liptuga on 07.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "UIImage+DPGradientImage.h"

@implementation UIImage (DPGradientImage)

+ (UIImage*) convertGradientToImage: (NSArray*) colors frame : (CGRect) frame{
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    layer.frame = frame;
    NSMutableArray *colorsRef = [[NSMutableArray alloc] init];
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < colors.count; i++) {
        UIColor *color = colors[i];
        
        [colorsRef addObject: (id) color.CGColor];
        
        CGFloat location = (CGFloat)i / (CGFloat)(colors.count - 1);
        NSNumber *locationNumber = [[NSNumber alloc] initWithFloat: location];
        
        [locations addObject: locationNumber];
    }
    
    layer.colors = colorsRef;
    layer.locations = locations;
    
    UIGraphicsBeginImageContext(layer.bounds.size);
    [layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // return the gradient image
    return gradientImage;
    
}

@end
