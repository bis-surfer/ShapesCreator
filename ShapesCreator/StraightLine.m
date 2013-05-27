//
//  StraightLine.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 24.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "StraightLine.h"


@implementation StraightLine

@synthesize alpha, p;

const double const_default_alpha = - 90.0;
const double const_default_p = 0.0;

- (double)default_alpha {
    
    return const_default_alpha;
}

- (double)default_p {
    
    return const_default_p;
}

- (id)init {
    
    return [self initWithSupershape:nil alpha:self.default_alpha p:self.default_p t_min:self.default_t_min t_max:self.default_t_max andSteps:self.default_steps];
}

- (id)initWithSupershape:(Shape*)theSuperShape alpha:(double)the_alpha p:(double)the_p t_min:(double)the_t_min t_max:(double)the_t_max andSteps:(NSUInteger)the_steps {
    
    self = [super initWithSupershape:theSuperShape t_min:the_t_min t_max:the_t_max andSteps:the_steps];
    
    if (self) {
        
        self.title = @"Straight Line";
        self.isBuiltIn = YES;
        self.iconName = @"shape_icon_StraightLine.png";
        
        self.alpha = the_alpha;
        self.p     = the_p;
    }
    
    return self;
}

- (double)x:(double)t {
    
    return p*cos(d2r*alpha) - t*sin(d2r*alpha);
}

- (double)y:(double)t {
    
    return p*sin(d2r*alpha) + t*cos(d2r*alpha);
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
        
        self.alpha = [decoder decodeDoubleForKey:@"alpha"];
        self.p = [decoder decodeDoubleForKey:@"p"];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required) 
// Parameters: encoder - an archiver object. 
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [super encodeWithCoder:encoder];
    
    [encoder encodeDouble:alpha forKey:@"alpha"];
    [encoder encodeDouble:p forKey:@"p"];
}

@end
