//
//  Circle.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 21.11.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "Circle.h"


@implementation Circle

@synthesize x0, y0, R;

const double const_default_c_x0 = 0.0;
const double const_default_c_y0 = 0.0;
const double const_default_R    = 1.0;

- (double)default_x0 {
    
    return const_default_c_x0;
}

- (double)default_y0 {
    
    return const_default_c_y0;
}

- (double)default_R {
    
    return const_default_R;
}

- (id)init {
    
    return [self initWithSupershape:nil x0:self.default_x0 y0:self.default_y0 r:self.default_R];
}

- (id)initWithSupershape:(Shape*)theSuperShape x0:(double)the_x0 y0:(double)the_y0 r:(double)the_R {
    
    self = [super initWithSupershape:theSuperShape t_min:0.0 t_max:360.0 andSteps:144];
    
    if (self) {
        
        self.title = @"Circle";
        self.isBuiltIn = YES;
        self.iconName = @"shape_icon_Circle.png";
        
        self.x0 = the_x0;
        self.y0 = the_y0;
        self.R  = the_R;
    }
    
    return self;
}

- (double)x:(double)t {
    
    return x0 + R*cos(d2r*t);
}

- (double)y:(double)t {
    
    return y0 + R*sin(d2r*t);
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
        self.R = [decoder decodeDoubleForKey:@"R"];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required)
// Parameters: encoder - an archiver object.
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [super encodeWithCoder:encoder];
    
    [encoder encodeDouble:x0 forKey:@"x0"];
    [encoder encodeDouble:y0 forKey:@"y0"];
    [encoder encodeDouble:R forKey:@"R"];
}

@end
