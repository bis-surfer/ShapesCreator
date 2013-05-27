//
//  Repository.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 26.02.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "Repository.h"

@implementation Repository

@synthesize shapesCollection;

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        shapesCollection = [[ShapesCollection alloc] init];
    }
    
    return self;
}

#pragma mark - NSCoding Protocol methods 

// Returns an object initialized from data in a given unarchiver (required) 
// Parameters: decoder - an unarchiver object. 
// Return Value: self, initialized using the data in decoder. 
- (id)initWithCoder:(NSCoder *)decoder {
	
    self = [super init];
    
    if (self) {
        
        self.shapesCollection = [decoder decodeObjectForKey:@"shapesCollection"];
        if (!shapesCollection) {
            shapesCollection = [[ShapesCollection alloc] init];
        }
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required) 
// Parameters: encoder - an archiver object. 
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:shapesCollection forKey:@"shapesCollection"];
}

@end
