//
//  AffineTransformation.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 29.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Transformation.h"


struct AT_Matrix {
    
    double a_11;
    double a_12;
    double a_13;
    double a_21;
    double a_22;
    double a_23;
    double a_31;
    double a_32;
    double a_33;
};


@interface AffineTransformation : Transformation {
    
    // Current Transformation Matrix (CTM) 
    struct AT_Matrix CTM;
    
    // scaling (stretching) along corresponding axes 
    double s_x;
    double s_y;
    
    // rotation (counterclockwise) angle (degrees) 
    double alpha;
    
    // translation along corresponding axes 
    double t_x;
    double t_y;
}

@property (nonatomic) struct AT_Matrix CTM;
@property (nonatomic) double s_x;
@property (nonatomic) double s_y;
@property (nonatomic) double alpha;
@property (nonatomic) double t_x;
@property (nonatomic) double t_y;


- (id)initWith_s_x:(double)the_s_x s_y:(double)the_s_y alpha:(double)the_alpha t_x:(double)the_t_x t_y:(double)the_t_y;
- (id)initWithTransformation:(AffineTransformation*)T;

- (void)computeCTM;
- (void)applyTransformation:(AffineTransformation*)T;


@end
