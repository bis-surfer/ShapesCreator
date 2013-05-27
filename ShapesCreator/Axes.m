//
//  Axes.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 12.02.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "Axes.h"

#import "StraightLine.h"
#import "AffineTransformation.h"


@implementation Axes

@synthesize x_axis_length, y_axis_length;
@synthesize scaleInterval;

const double const_default_x_axis_length = 12.0;
const double const_default_y_axis_length = 12.0;
const double const_default_scaleInterval = 1.0;

- (double)default_x_axis_length {
    
    return const_default_x_axis_length;
}

- (double)default_y_axis_length {
    
    return const_default_y_axis_length;
}

- (double)default_scaleInterval {
    
    return const_default_scaleInterval;
}

- (id)init {
    
    return [self initWithSupershape:nil x_axis_length:self.default_x_axis_length y_axis_length:self.default_y_axis_length scaleInterval:self.default_scaleInterval];
}

- (id)initWithSupershape:(Shape*)theSuperShape x_axis_length:(double)the_x_axis_length y_axis_length:(double)the_y_axis_length scaleInterval:(double)the_scaleInterval {
    
    self = [super initWithSupershape:theSuperShape];
    
    if (self) {
        
        self.title = @"Axes";
        self.isBuiltIn = YES;
        self.iconName = @"shape_icon_Axes.png";
        
        self.x_axis_length = the_x_axis_length;
        self.y_axis_length = the_y_axis_length;
        self.scaleInterval = the_scaleInterval;
        
        [self populate];
        [self applyTheSelfStyleForSubShapes];
        self.style.outlineColor = [UIColor grayColor];
    }
    
    return self;
}

- (void)populate {
    
    StraightLine *x_axis = [[StraightLine alloc] initWithSupershape:self alpha:-90.0 p:0.0 t_min:-0.5*x_axis_length t_max:0.5*x_axis_length andSteps:2];
    StraightLine *y_axis = [[StraightLine alloc] initWithSupershape:self alpha:0.0 p:0.0 t_min:-0.5*y_axis_length t_max:0.5*y_axis_length andSteps:2];
    
    [subShapes addObject:x_axis];
    [subShapes addObject:y_axis];
    
    const double gtsir = 0.10;
    NSInteger numberOfGraduations = (NSInteger)(0.5*x_axis_length/scaleInterval);
    NSInteger g = 1 - numberOfGraduations;
    while ( g < numberOfGraduations) {
        if (g != 0) {
            StraightLine *x_graduation = [[StraightLine alloc] initWithSupershape:self alpha:0.0 p:g*scaleInterval t_min:-0.5*gtsir*scaleInterval t_max:0.5*gtsir*scaleInterval andSteps:2];
            [subShapes addObject:x_graduation];
        }
        g++;
    }
    numberOfGraduations = (NSUInteger)(0.5*y_axis_length/scaleInterval);
    g = 1 - numberOfGraduations;
    while ( g < numberOfGraduations) {
        if (g != 0) {
            StraightLine *y_graduation = [[StraightLine alloc] initWithSupershape:self alpha:-90.0 p:-g*scaleInterval t_min:-0.5*gtsir*scaleInterval t_max:0.5*gtsir*scaleInterval andSteps:2];
            [subShapes addObject:y_graduation];
        }
        g++;
    }
}

#pragma mark - NSCoding Protocol methods 

// Returns an object initialized from data in a given unarchiver (required) 
// Parameters: decoder - an unarchiver object. 
// Return Value: self, initialized using the data in decoder. 
- (id)initWithCoder:(NSCoder *)decoder {
	
    self = [super initWithCoder:decoder];
    
    if (self) {
        
        self.x_axis_length = [decoder decodeDoubleForKey:@"x_axis_length"];
        self.y_axis_length = [decoder decodeDoubleForKey:@"y_axis_length"];
        self.scaleInterval = [decoder decodeDoubleForKey:@"scaleInterval"];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required) 
// Parameters: encoder - an archiver object. 
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [super encodeWithCoder:encoder];
    
    [encoder encodeDouble:x_axis_length forKey:@"x_axis_length"];
    [encoder encodeDouble:y_axis_length forKey:@"y_axis_length"];
    [encoder encodeDouble:scaleInterval forKey:@"scaleInterval"];
}

@end
