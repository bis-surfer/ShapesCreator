//
//  StraightLine.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 24.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ParametricCurve.h"


@interface StraightLine : ParametricCurve {
    
    double alpha;
    double p;
}

@property (nonatomic) double alpha;
@property (nonatomic) double p;


- (double)default_alpha;
- (double)default_p;


- (id)initWithSupershape:(Shape*)theSuperShape alpha:(double)the_alpha p:(double)the_p t_min:(double)the_t_min t_max:(double)the_t_max andSteps:(NSUInteger)the_steps;


@end
