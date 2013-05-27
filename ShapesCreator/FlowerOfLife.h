//
//  FlowerOfLife.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 23.11.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RotationNOrderSymmetricalShape.h"


@interface FlowerOfLife : RotationNOrderSymmetricalShape {
    
    double singleSpace;
    double singleRadius;
    
    NSUInteger linesCount;
    
    BOOL drawEnvelope;
}

@property (nonatomic) double singleSpace;
@property (nonatomic) double singleRadius;

@property (nonatomic) NSUInteger linesCount;

@property (nonatomic) BOOL drawEnvelope;


- (id)initWithSupershape:(Shape*)theSuperShape orderOfSymmetry:(NSUInteger)theOrderOfSymmetry singleSpace:(double)theSingleSpace singleRadius:(double)theSingleRadius linesCount:(NSUInteger)theLinesCount andEnvelope:(BOOL)theDrawEnvelope;


@end
