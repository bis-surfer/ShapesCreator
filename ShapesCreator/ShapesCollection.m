//
//  ShapesCollection.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 26.02.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "ShapesCollection.h"

#import "StraightLine.h"
#import "Axes.h"
#import "Rectangle.h"
#import "Circle.h"
#import "FlowerOfLife.h"
#import "LogarithmicSpiral.h"
#import "ExperimentalShape.h"
#import "WallDesignSketch.h"


@implementation ShapesCollection

- (id)init {
	
    self = [super init];
    
    if (self) {
        
        builtInFolder.title = @"built-in Shapes";
        [self populateBuiltInFolder];
        [self populateRootFolder];
    }
    
    return self;
}

- (void)populateBuiltInFolder {
    
    StraightLine *line = [[StraightLine alloc] init];
    [builtInFolder addDataObject:line];
    
    Rectangle *rectangle = [[Rectangle alloc] init];
    [builtInFolder addDataObject:rectangle];
    
    Circle *circle = [[Circle alloc] init];
    [builtInFolder addDataObject:circle];
    
    FlowerOfLife *flower = [[FlowerOfLife alloc] init];
    [builtInFolder addDataObject:flower];
    
    LogarithmicSpiral *logSpiral = [[LogarithmicSpiral alloc] init];
    [builtInFolder addDataObject:logSpiral];
    
    Axes *axes = [[Axes alloc] init];
    [builtInFolder addDataObject:axes];
}

- (void)populateRootFolder {
    
    Folder *favoriteFolder = [[Folder alloc] initWithTitle:@"Favorite Shapes" andSuperfolder:rootFolder];
    [rootFolder addSubfolder:favoriteFolder];
    
    ExperimentalShape *experimentalShape = [[ExperimentalShape alloc] init];
    [rootFolder addDataObject:experimentalShape];
    
    WallDesignSketch *wallSketch = [[WallDesignSketch alloc] init];
    [rootFolder addDataObject:wallSketch];
}

#pragma mark - NSCoding Protocol methods 

// Returns an object initialized from data in a given unarchiver (required) 
// Parameters: decoder - an unarchiver object. 
// Return Value: self, initialized using the data in decoder. 
- (id)initWithCoder:(NSCoder *)decoder {
	
    self = [super initWithCoder:decoder];
    
    if (self) {
        
        builtInFolder.title = @"built-in Shapes";
        [self populateBuiltInFolder];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required) 
// Parameters: encoder - an archiver object. 
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [super encodeWithCoder:encoder];
}

@end
