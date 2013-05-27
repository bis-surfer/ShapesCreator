//
//  Rectangle.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 05.10.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//
//

#import "ParametricCurve.h"


@interface Rectangle : ParametricCurve {
    
    double x0;
    double y0;
    double xs;
    double ys;
}

@property (nonatomic) double x0;
@property (nonatomic) double y0;
@property (nonatomic) double xs;
@property (nonatomic) double ys;


- (double)default_x0;
- (double)default_y0;
- (double)default_xs;
- (double)default_ys;


- (id)initWithSupershape:(Shape*)theSuperShape x0:(double)the_x0 y0:(double)the_y0 xs:(double)the_xs ys:(double)the_ys;


@end
