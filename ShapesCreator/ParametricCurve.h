//
//  ParametricCurve.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 23.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Shape.h"


@interface ParametricCurve : Shape {
    
    // Values of parameter (t) corresponding to the ends of section of curve we'll draw 
    double t_min;
    double t_max;
    
    // Number of path elements used to draw path representing the ParametricCurve 
    NSUInteger steps;
}

@property (nonatomic) double t_min;
@property (nonatomic) double t_max;
@property (nonatomic) NSUInteger steps;


- (double)default_t_min;
- (double)default_t_max;
- (double)default_steps;


- (id)initWithSupershape:(Shape*)theSuperShape t_min:(double)the_t_min t_max:(double)the_t_max andSteps:(NSUInteger)the_steps;

// We'll use setting of curve in parametric form at the Shape coordinate system (in units) 
- (double)x:(double)t;
- (double)y:(double)t;
- (double)z:(double)t;


@end
