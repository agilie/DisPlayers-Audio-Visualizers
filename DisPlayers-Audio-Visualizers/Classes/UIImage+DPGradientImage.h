//
//  UIImage+GradientImage.h
//  Equalizers
//
//  Created by Michael Liptuga on 07.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DPGradientImage)

+ (UIImage*) convertGradientToImage: (NSArray*) colors frame : (CGRect) frame;

@end
