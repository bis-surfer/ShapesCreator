//
//  LogarithmicSpiral.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 24.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "LogarithmicSpiral.h"


@implementation LogarithmicSpiral

@synthesize r_0, growth, omega, t_0;

const double const_default_r_0 = 1.0;
const double const_default_growth = 2.0;
const double const_default_omega = - 2.0*M_PI;
const double const_default_t_0 = 0.0;

- (double)default_r_0 {
    
    return const_default_r_0;
}

- (double)default_growth {
    
    return const_default_growth;
}

- (double)default_omega {
    
    return const_default_omega;
}

- (double)default_t_0 {
    
    return const_default_t_0;
}

- (id)init {
    
    // double golden_mean = (sqrt(5.0) + 1.0)/2.0;
    
    return [self initWithSupershape:nil r_0:self.default_r_0 growth:self.default_growth omega:self.default_omega t_0:self.default_t_0 t_min:self.default_t_min t_max:self.default_t_max andSteps:self.default_steps];
}

- (id)initWithSupershape:(Shape*)theSuperShape r_0:(double)the_r_0 growth:(double)the_growth omega:(double)the_omega t_0:(double)the_t_0 t_min:(double)the_t_min t_max:(double)the_t_max andSteps:(NSUInteger)the_steps {
    
    self = [super initWithSupershape:theSuperShape t_min:the_t_min t_max:the_t_max andSteps:the_steps];
    
    if (self) {
        
        self.title = @"Logarithmic Spiral";
        self.isBuiltIn = YES;
        self.iconName = @"shape_icon_LogarithmicSpiral.png";
        
        self.r_0    = the_r_0;
        self.growth = the_growth;
        self.omega  = the_omega;
        self.t_0    = the_t_0;
    }
    
    return self;
}

- (double)x:(double)t {
    
    return r_0*exp(log(growth)*t)*cos(omega*(t - t_0));
}

- (double)y:(double)t {
    
    return r_0*exp(log(growth)*t)*sin(omega*(t - t_0));
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
        
        self.r_0 = [decoder decodeDoubleForKey:@"r_0"];
        self.growth = [decoder decodeDoubleForKey:@"growth"];
        self.omega = [decoder decodeDoubleForKey:@"omega"];
        self.t_0 = [decoder decodeDoubleForKey:@"t_0"];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required) 
// Parameters: encoder - an archiver object. 
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [super encodeWithCoder:encoder];
    
    [encoder encodeDouble:r_0 forKey:@"r_0"];
    [encoder encodeDouble:growth forKey:@"growth"];
    [encoder encodeDouble:omega forKey:@"omega"];
    [encoder encodeDouble:t_0 forKey:@"t_0"];
}

@end
