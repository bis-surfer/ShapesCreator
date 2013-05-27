//
//  Transformation.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 29.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "Transformation.h"


const double d2r = M_PI/180.0;


@implementation Transformation

- (struct Coordinates)transformedCoordinatesFromOriginalCoordinates:(struct Coordinates)oC {
    
    return oC;
}

#pragma mark - NSCoding Protocol methods 

// Returns an object initialized from data in a given unarchiver (required) 
// Parameters: decoder - an unarchiver object. 
// Return Value: self, initialized using the data in decoder. 
- (id)initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    
    return self;
}

// Encodes the receiver using a given archiver (required) 
// Parameters: encoder - an archiver object. 
- (void)encodeWithCoder:(NSCoder *)encoder {
    
}

@end
