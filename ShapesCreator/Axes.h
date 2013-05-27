//
//  Axes.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 12.02.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Shape.h"


@interface Axes : Shape {
    
    double x_axis_length;
    double y_axis_length;
    
    double scaleInterval;
}

@property (nonatomic) double x_axis_length;
@property (nonatomic) double y_axis_length;
@property (nonatomic) double scaleInterval;


- (double)default_x_axis_length;
- (double)default_y_axis_length;
- (double)default_scaleInterval;


- (id)initWithSupershape:(Shape*)theSuperShape x_axis_length:(double)the_x_axis_length y_axis_length:(double)the_y_axis_length scaleInterval:(double)the_scaleInterval;


@end
