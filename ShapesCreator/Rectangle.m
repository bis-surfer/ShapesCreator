//
//  Rectangle.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 05.10.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//
//

#import "Rectangle.h"


@implementation Rectangle

@synthesize x0, y0, xs, ys;

const double const_default_r_x0 = 0.0;
const double const_default_r_y0 = 0.0;
const double const_default_xs   = 2.0;
const double const_default_ys   = 2.0;

- (double)default_x0 {
    
    return const_default_r_x0;
}

- (double)default_y0 {
    
    return const_default_r_y0;
}

- (double)default_xs {
    
    return const_default_xs;
}

- (double)default_ys {
    
    return const_default_ys;
}

- (id)init {
    
    return [self initWithSupershape:nil x0:self.default_x0 y0:self.default_y0 xs:self.default_xs ys:self.default_ys];
}

- (id)initWithSupershape:(Shape*)theSuperShape x0:(double)the_x0 y0:(double)the_y0 xs:(double)the_xs ys:(double)the_ys {
    
    self = [super initWithSupershape:theSuperShape t_min:0.0 t_max:1.0 andSteps:4];
    
    if (self) {
        
        self.title = @"Rectangle";
        self.isBuiltIn = YES;
        self.iconName = @"shape_icon_Rectangle.png";
        
        self.x0 = the_x0;
        self.y0 = the_y0;
        self.xs = the_xs;
        self.ys = the_ys;
    }
    
    return self;
}

- (double)x:(double)t {
    
    BOOL isRightSide = (t < (t_max - t_min)*1.0/8.0 || t > (t_max - t_min)*5.0/8.0);
    
    return x0 + 0.5*(isRightSide? 1.0 : -1.0)*xs;
}

- (double)y:(double)t {
    
    BOOL isTopSide = (t < (t_max - t_min)*3.0/8.0 || t > (t_max - t_min)*7.0/8.0);
    
    return y0 + 0.5*(isTopSide? 1.0 : -1.0)*ys;
}

- (double)z:(double)t {
    
    return 0.0;
}

#pragma mark - NSCoding Protocol methods

// Returns an object initialized from data in a given unarchiver (required)
// Parameters: decoder - an unarchiver object.
// Return Value: self, initialized using the data in decoder.
- (id)initWithCoder:(NSCoder *)decoder {
	
    self = [super initWithCoder:decoder];
    
    if (self) {
        
        self.x0 = [decoder decodeDoubleForKey:@"x0"];
        self.y0 = [decoder decodeDoubleForKey:@"y0"];
        self.xs = [decoder decodeDoubleForKey:@"xs"];
        self.ys = [decoder decodeDoubleForKey:@"ys"];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required)
// Parameters: encoder - an archiver object.
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [super encodeWithCoder:encoder];
    
    [encoder encodeDouble:x0 forKey:@"x0"];
    [encoder encodeDouble:y0 forKey:@"y0"];
    [encoder encodeDouble:xs forKey:@"xs"];
    [encoder encodeDouble:ys forKey:@"ys"];
}

@end
