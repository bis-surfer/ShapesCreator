//
//  Transformation.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 29.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>


extern const double d2r;

struct Coordinates {
    
    double x;
    double y;
    double z;
};


@interface Transformation : NSObject <NSCoding> {
    
}


- (struct Coordinates)transformedCoordinatesFromOriginalCoordinates:(struct Coordinates)oC;


@end
