//
//  DPRollingEqualizerView.m
//  Equalizers
//
//  Created by Michael Liptuga on 09.03.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

#import "DPRollingEqualizerView.h"



@implementation DPRollingEqualizerView

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGRect frame = self.bounds;
    
    [(UIColor *)self.backgroundColor set];
    UIRectFill(frame);
    
    CGFloat columnWidth = (rect.size.width / 2) / (self.equalizerSettings.numOfBins - 1);
    
    CGFloat actualWidth = MAX(1, columnWidth * (1 - 2 * self.equalizerSettings.padding));
    CGFloat actualPadding = MAX(0, (columnWidth - actualWidth) / 2);
    
    for (NSUInteger i = 0; i < self.equalizerSettings.numOfBins; i++) {
        CGFloat columnHeight = [[self.audioService timeHeights][i] floatValue] / 2;
        
        if (columnHeight <= 0)
            continue;
        CGFloat columnX = i * columnWidth;
        
        UIBezierPath *rollingPath = [[UIBezierPath alloc] init];
        rollingPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(columnX + actualPadding,
                                                                        CGRectGetHeight(frame)/2 - columnHeight/2,
                                                                        actualWidth,
                                                                        columnHeight)
                                                 cornerRadius: actualWidth];
        
        [self.equalizerBinColor setFill];
        
        [rollingPath fill];
    }
    
    [self.equalizerBinColor setStroke];

    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
        linePath.lineWidth = 2.0;
        [linePath moveToPoint: CGPointMake(CGRectGetWidth(rect) / 2 + actualPadding, CGRectGetHeight(rect) / 2)];
        [linePath addLineToPoint: CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) / 2)];
        [linePath stroke];
    
    CGContextRestoreGState(ctx);
}

@end
