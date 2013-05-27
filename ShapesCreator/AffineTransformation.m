//
//  AffineTransformation.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 29.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "AffineTransformation.h"


@implementation AffineTransformation

@synthesize CTM;
@synthesize s_x, s_y, alpha, t_x, t_y;

- (id)init {
	
    self = [super init];
    
    if (self) {
        
        // Identity transform 
        self.s_x   = 1.0;
        self.s_y   = 1.0;
        self.alpha = 0.0;
        self.t_x   = 0.0;
        self.t_y   = 0.0;
        
        [self computeCTM];
    }
    
    return self;
}

- (id)initWith_s_x:(double)the_s_x s_y:(double)the_s_y alpha:(double)the_alpha t_x:(double)the_t_x t_y:(double)the_t_y {
	
    self = [super init];
    
    if (self) {
        
        self.s_x   = the_s_x;
        self.s_y   = the_s_y;
        self.alpha = the_alpha;
        self.t_x   = the_t_x;
        self.t_y   = the_t_y;
        
        [self computeCTM];
    }
    
    return self;
}

- (id)initWithTransformation:(AffineTransformation*)T {
    
    return [self initWith_s_x:T.s_x s_y:T.s_y alpha:T.alpha t_x:T.t_x t_y:T.t_y];
}

- (void)computeCTM {
    
    CTM.a_11 =   s_x*cos(d2r*alpha);
    CTM.a_12 =   s_x*sin(d2r*alpha);
    CTM.a_13 =   0.0;
    CTM.a_21 = - s_y*sin(d2r*alpha);
    CTM.a_22 =   s_y*cos(d2r*alpha);
    CTM.a_23 =   0.0;
    CTM.a_31 =   t_x;
    CTM.a_32 =   t_y;
    CTM.a_33 =   1.0;
}

- (void)applyTransformation:(AffineTransformation*)T {
    
    double a_11 = CTM.a_11*T.CTM.a_11 + CTM.a_12*T.CTM.a_21 + CTM.a_13*T.CTM.a_31;
    double a_12 = CTM.a_11*T.CTM.a_12 + CTM.a_12*T.CTM.a_22 + CTM.a_13*T.CTM.a_32;
    double a_13 = CTM.a_11*T.CTM.a_13 + CTM.a_12*T.CTM.a_23 + CTM.a_13*T.CTM.a_33;
    double a_21 = CTM.a_21*T.CTM.a_11 + CTM.a_22*T.CTM.a_21 + CTM.a_23*T.CTM.a_31;
    double a_22 = CTM.a_21*T.CTM.a_12 + CTM.a_22*T.CTM.a_22 + CTM.a_23*T.CTM.a_32;
    double a_23 = CTM.a_21*T.CTM.a_13 + CTM.a_22*T.CTM.a_23 + CTM.a_23*T.CTM.a_33;
    double a_31 = CTM.a_31*T.CTM.a_11 + CTM.a_32*T.CTM.a_21 + CTM.a_33*T.CTM.a_31;
    double a_32 = CTM.a_31*T.CTM.a_12 + CTM.a_32*T.CTM.a_22 + CTM.a_33*T.CTM.a_32;
    double a_33 = CTM.a_31*T.CTM.a_13 + CTM.a_32*T.CTM.a_23 + CTM.a_33*T.CTM.a_33;
    
    CTM.a_11 = a_11;
    CTM.a_12 = a_12;
    CTM.a_13 = a_13;
    CTM.a_21 = a_21;
    CTM.a_22 = a_22;
    CTM.a_23 = a_23;
    CTM.a_31 = a_31;
    CTM.a_32 = a_32;
    CTM.a_33 = a_33;
}

- (struct Coordinates)transformedCoordinatesFromOriginalCoordinates:(struct Coordinates)oC {
    
    struct Coordinates tC;
    
    tC.x = oC.x*CTM.a_11 + oC.y*CTM.a_21 + 1.0*CTM.a_31;
    tC.y = oC.x*CTM.a_12 + oC.y*CTM.a_22 + 1.0*CTM.a_32;
    tC.z = oC.z;
    
    return tC;
}

#pragma mark - NSCoding Protocol methods 

// Returns an object initialized from data in a given unarchiver (required) 
// Parameters: decoder - an unarchiver object. 
// Return Value: self, initialized using the data in decoder. 
- (id)initWithCoder:(NSCoder *)decoder {
	
    self = [super initWithCoder:decoder];
    
    if (self) {
        
        self.s_x = [decoder decodeDoubleForKey:@"s_x"];
        self.s_y = [decoder decodeDoubleForKey:@"s_y"];
        self.alpha = [decoder decodeDoubleForKey:@"alpha"];
        self.t_x = [decoder decodeDoubleForKey:@"t_x"];
        self.t_y = [decoder decodeDoubleForKey:@"t_y"];
        
        [self computeCTM];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required) 
// Parameters: encoder - an archiver object. 
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [super encodeWithCoder:encoder];
    
    [encoder encodeDouble:s_x forKey:@"s_x"];
    [encoder encodeDouble:s_y forKey:@"s_y"];
    [encoder encodeDouble:alpha forKey:@"alpha"];
    [encoder encodeDouble:t_x forKey:@"t_x"];
    [encoder encodeDouble:t_y forKey:@"t_y"];
}

@end
