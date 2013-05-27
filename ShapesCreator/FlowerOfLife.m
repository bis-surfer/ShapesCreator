//
//  FlowerOfLife.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 23.11.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "FlowerOfLife.h"

#import "Circle.h"
#import "FlowerOfLifePetal.h"

#import "AffineTransformation.h"


@implementation FlowerOfLife

@synthesize singleSpace;
@synthesize singleRadius;
@synthesize linesCount;
@synthesize drawEnvelope;

- (id)init {
    
    return [self initWithSupershape:nil orderOfSymmetry:6 singleSpace:0.5 singleRadius:0.5 linesCount:3 andEnvelope:YES];
}

- (id)initWithSupershape:(Shape*)theSuperShape orderOfSymmetry:(NSUInteger)theOrderOfSymmetry singleSpace:(double)theSingleSpace singleRadius:(double)theSingleRadius linesCount:(NSUInteger)theLinesCount andEnvelope:(BOOL)theDrawEnvelope {
    
    FlowerOfLifePetal *petal = [[FlowerOfLifePetal alloc] initWithSupershape:self orderOfSymmetry:theOrderOfSymmetry singleSpace:theSingleSpace singleRadius:theSingleRadius andLinesCount:theLinesCount];
    
    self = [super initWithSupershape:theSuperShape elementalShape:petal andOrderOfSymmetry:theOrderOfSymmetry];
    
    if (self) {
        
        self.title = @"Flower of Life";
        self.isBuiltIn = YES;
        self.iconName = @"shape_icon_FlowerOfLife.png";
        
        self.singleSpace  = theSingleSpace;
        self.singleRadius = theSingleRadius;
        self.linesCount   = theLinesCount;
        self.drawEnvelope = theDrawEnvelope;
        
        [self populate];
        // [self applyTheSelfStyleForSubShapes];
        // self.style.outlineColor = [UIColor blackColor];
    }
    
    return self;
}

- (void)populate {
    
    Shape *elementalShape = [subShapes objectAtIndex:0];
    
    AffineTransformation *rTranform = [[AffineTransformation alloc] initWith_s_x:1.0 s_y:1.0 alpha:(0.5*360.0/n) t_x:0.0 t_y:0.0];
    [elementalShape addTransformation:rTranform];
    
    Circle *circle = [[Circle alloc] initWithSupershape:self x0:0.0 y0:0.0 r:singleRadius];
    [subShapes addObject:circle];
    
    if (drawEnvelope) {
        
        Circle *circle = [[Circle alloc] initWithSupershape:self x0:0.0 y0:0.0 r:((linesCount - 1)*singleSpace + singleRadius)];
        [subShapes addObject:circle];
    }
}

#pragma mark - NSCoding Protocol methods

// Returns an object initialized from data in a given unarchiver (required)
// Parameters: decoder - an unarchiver object.
// Return Value: self, initialized using the data in decoder.
- (id)initWithCoder:(NSCoder *)decoder {
	
    self = [super initWithCoder:decoder];
    
    if (self) {
        
        self.singleSpace  = [decoder decodeDoubleForKey:@"singleSpace"];
        self.singleRadius = [decoder decodeDoubleForKey:@"singleRadius"];
        self.linesCount   = [[decoder decodeObjectForKey:@"linesCount"] unsignedIntegerValue];
        self.drawEnvelope = [decoder decodeBoolForKey:@"drawEnvelope"];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required)
// Parameters: encoder - an archiver object.
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [super encodeWithCoder:encoder];
    
    [encoder encodeDouble:singleSpace forKey:@"singleSpace"];
    [encoder encodeDouble:singleRadius forKey:@"singleRadius"];
    [encoder encodeObject:[NSNumber numberWithUnsignedInteger:linesCount] forKey:@"linesCount"];
    [encoder encodeBool:drawEnvelope forKey:@"drawEnvelope"];
}

@end
