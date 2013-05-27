//
//  Circle.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 21.11.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ParametricCurve.h"


@interface Circle : ParametricCurve {
    
    double x0;
    double y0;
    double R;
}

@property (nonatomic) double x0;
@property (nonatomic) double y0;
@property (nonatomic) double R;


- (double)default_x0;
- (double)default_y0;
- (double)default_R;


- (id)initWithSupershape:(Shape*)theSuperShape x0:(double)the_x0 y0:(double)the_y0 r:(double)the_R;


@end
