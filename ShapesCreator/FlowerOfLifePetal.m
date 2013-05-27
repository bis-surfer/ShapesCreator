//
//  FlowerOfLifePetal.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 12.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "FlowerOfLifePetal.h"

#import "Circle.h"

#import "AffineTransformation.h"


@implementation FlowerOfLifePetal

- (id)initWithSupershape:(Shape*)theSuperShape orderOfSymmetry:(NSUInteger)theOrderOfSymmetry singleSpace:(double)space singleRadius:(double)radius andLinesCount:(NSUInteger)theLinesCount {
    
    self = [super initWithSupershape:theSuperShape];
    
    if (self) {
        
        self.title = @"Flower of Life Petal";
        self.isBuiltIn = YES;
        
        double alpha = M_PI/theOrderOfSymmetry;
        double dp = 2.0*space*sin(alpha);
        double dq = space*cos(alpha);
        BOOL drawOddLines = YES;
        if (theOrderOfSymmetry == 4) {
            drawOddLines = NO;
        }
        BOOL drawEvenLines = YES;
        
        for (NSUInteger lineNumber = 1; lineNumber < theLinesCount; lineNumber++) {
            
            if ( ((lineNumber%2 != 0) && drawOddLines) || ((lineNumber%2 == 0) && drawEvenLines)) {
                
                Circle *circle = [[Circle alloc] initWithSupershape:self x0:(-0.5*dp*lineNumber) y0:(dq*lineNumber) r:radius];
                [subShapes addObject:circle];
                
                for (NSUInteger circleNumber = 1; circleNumber < lineNumber; circleNumber++) {
                    
                    AffineTransformation *translation = [[AffineTransformation alloc] initWith_s_x:1.0 s_y:1.0 alpha:0.0 t_x:dp*circleNumber t_y:0.0];
                    [circle cloneWithTransformation:translation];
                }
            }
        }
    }
    
    return self;
}

/* // Uncomment this only for the debugging issues 
- (void)drawAtRect:(CGRect)rect {
    
    [self drawElementWithTransformation:[multiplicateTransformations objectAtIndex:0] AtRect:rect];
}
 */

@end
