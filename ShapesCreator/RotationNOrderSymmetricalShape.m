//
//  RotationNOrderSymmetricalShape.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 11.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "RotationNOrderSymmetricalShape.h"

#import "AffineTransformation.h"


@implementation RotationNOrderSymmetricalShape

@synthesize n;

- (id)initWithSupershape:(Shape*)theSuperShape elementalShape:(Shape*)theElementalShape andOrderOfSymmetry:(NSUInteger)theOrderOfSymmetry {
	
    self = [super initWithSupershape:theSuperShape andElementalShape:theElementalShape];
    
    if (self) {
        
        self.title = @"Shape with n-order rotation symmetry";
        self.iconName = @"shape_icon_RotationNOrderSymmetricalShape.png";
        
        self.n = theOrderOfSymmetry;
        
        [self multiplicateSubshape];
    }
    
    return self;
}

- (void)multiplicateSubshape {
    
    Shape *subshape = [subShapes objectAtIndex:0];
    
    for (NSUInteger cloneNumber = 1; cloneNumber < n; cloneNumber++) {
        
        double alpha = 360.0/n*cloneNumber;
        AffineTransformation *cloningTransformation = [[AffineTransformation alloc] initWith_s_x:1.0 s_y:1.0 alpha:alpha t_x:0.0 t_y:0.0];
        [subshape cloneWithTransformation:cloningTransformation];
    }
}

#pragma mark - NSCoding Protocol methods

// Returns an object initialized from data in a given unarchiver (required)
// Parameters: decoder - an unarchiver object.
// Return Value: self, initialized using the data in decoder.
- (id)initWithCoder:(NSCoder *)decoder {
	
    self = [super initWithCoder:decoder];
    
    if (self) {
        
        self.n = [[decoder decodeObjectForKey:@"orderOfSymmetry"] unsignedIntegerValue];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required)
// Parameters: encoder - an archiver object.
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [super encodeWithCoder:encoder];
    
    [encoder encodeObject:[NSNumber numberWithUnsignedInteger:n] forKey:@"orderOfSymmetry"];
}

@end
