//
//  LogarithmicSpiral.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 24.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ParametricCurve.h"


@interface LogarithmicSpiral : ParametricCurve {
    
    double r_0;
    double growth;
    double omega;
    double t_0;
}

@property (nonatomic) double r_0;
@property (nonatomic) double growth;
@property (nonatomic) double omega;
@property (nonatomic) double t_0;


- (double)default_r_0;
- (double)default_growth;
- (double)default_omega;
- (double)default_t_0;


- (id)initWithSupershape:(Shape*)theSuperShape r_0:(double)the_r_0 growth:(double)the_growth omega:(double)the_omega t_0:(double)the_t_0 t_min:(double)the_t_min t_max:(double)the_t_max andSteps:(NSUInteger)the_steps;


@end
