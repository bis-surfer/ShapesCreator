//
//  FlowerOfLifePetal.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 12.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "Shape.h"


@interface FlowerOfLifePetal : Shape {
    
}

- (id)initWithSupershape:(Shape*)theSuperShape orderOfSymmetry:(NSUInteger)theOrderOfSymmetry singleSpace:(double)space singleRadius:(double)radius andLinesCount:(NSUInteger)theLinesCount;


@end
