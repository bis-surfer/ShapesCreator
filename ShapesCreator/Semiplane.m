//
//  Semiplane.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 27.09.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//
//

#import "Semiplane.h"

@implementation Semiplane

- (void)drawElementWithTransformation:(Transformation*)multiplicatingTransformation AtRect:(CGRect)rect {
    
    self.currentMultiplicatingTransformation = multiplicatingTransformation;
    
    /*
    // Origin of shape coordinate system screen coordinates (points)
    CGFloat x_0 = 0.0 - origin.x*unit;
    CGFloat y_0 = origin.y*unit;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    if (NO) {
        // CGContextSaveGState(c);
        CGContextAddRect(c, rect);
        CGContextClip(c);
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        CGFloat components[12] = { 1.00, 1.00, 1.00, 0.00,
            1.00, 1.00, 0.00, 0.50,
            1.00, 1.00, 1.00, 0.00 };
        
        CGFloat locations[3] = { 0.0, 0.5, 1.0 };
        
        // Paint the first gradient - from bottom to top --- >
        CGGradientRef gradient1 = CGGradientCreateWithColorComponents( colorSpace,
                                                                      components,
                                                                      locations,
                                                                      (size_t)3 );
        CGContextDrawLinearGradient(c, gradient1,
                                    CGPointMake(x_0, y_0 + unit),
                                    CGPointMake(x_0, y_0 - unit),
                                    (CGGradientDrawingOptions) NULL);
        
        CGGradientRelease(gradient1);
        // < --- first gradient is painted
        
        // Paint the second gradient - from left to right --- >
        CGGradientRef gradient2 = CGGradientCreateWithColorComponents( colorSpace,
                                                                      components,
                                                                      locations,
                                                                      (size_t)3 );
        CGContextDrawLinearGradient(c, gradient2,
                                    CGPointMake(x_0 - unit, y_0),
                                    CGPointMake(x_0 + unit, y_0),
                                    (CGGradientDrawingOptions) NULL);
        
        CGGradientRelease(gradient2);
        // < --- second gradient is painted
        
        CGColorSpaceRelease(colorSpace);
        // CGContextRestoreGState(c);
    }
    
    // CGContextSaveGState(c);
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, rect.origin.x, y_0);
    CGContextAddLineToPoint(c, rect.origin.x + rect.size.width, y_0);
    CGContextMoveToPoint(c, x_0, rect.origin.y);
    CGContextAddLineToPoint(c, x_0, rect.origin.y + rect.size.height);
    
    UIColor *color = [UIColor grayColor];
    CGContextSetStrokeColorWithColor(c, [color CGColor]);
    CGContextSetLineWidth(c, 1.0);
    CGContextStrokePath(c);
    // CGContextRestoreGState(c);
     */
    
    // And now let's draw the subshapes --- >
    [super drawElementWithTransformation:multiplicatingTransformation AtRect:rect];
    // < --- Subshapes are drawn
}

@end
