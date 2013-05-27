//
//  ExperimentalShape.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 12.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "ExperimentalShape.h"

#import "LogarithmicSpiral.h"
#import "Axes.h"

#import "AffineTransformation.h"


@implementation ExperimentalShape

- (id)initWithSupershape:(Shape*)theSuperShape {
    
    self = [super initWithSupershape:theSuperShape];
    
    if (self) {
        
        self.title = @"Experimental Shape";
        self.iconName = @"shape_icon_ExperimentalShape.png";
        [self populate];
    }
    
    return self;
}

- (void)populate {
    
    LogarithmicSpiral *logSpiral_1 = [[LogarithmicSpiral alloc] initWithSupershape:self r_0:1.0 growth:2.0 omega:(- 2.0*M_PI) t_0:0.0 t_min:-1.625 t_max:1.625 andSteps:4096];
    
    LogarithmicSpiral *logSpiral_2 = [[LogarithmicSpiral alloc] initWithSupershape:self r_0:-1.0 growth:2.0 omega:(- 2.0*M_PI) t_0:0.0 t_min:-1.625 t_max:1.625 andSteps:4096];
    
    logSpiral_2.t_0   += 1.0/24.0;
    logSpiral_2.t_min += 1.0/24.0;
    logSpiral_2.t_max += 1.0/24.0;
    
    AffineTransformation *t1 = [[AffineTransformation alloc] initWith_s_x:1.0 s_y:1.0 alpha:0.0 t_x:0.0 t_y:0.0];
    AffineTransformation *t2 = [[AffineTransformation alloc] initWith_s_x:1.0 s_y:1.0 alpha:0.0 t_x:0.0 t_y:0.0];
    
    [logSpiral_1 addTransformation:t1];
    [logSpiral_2 addTransformation:t2];
    
    [subShapes addObject:logSpiral_1];
    [subShapes addObject:logSpiral_2];
    
    Axes *axes = [[Axes alloc] initWithSupershape:self x_axis_length:12.0 y_axis_length:12.0 scaleInterval:1.0];
    
    [subShapes addObject:axes];
}

@end
