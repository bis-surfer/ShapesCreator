//
//  SymmetricalShape.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 11.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "Shape.h"


@interface SymmetricalShape : Shape {
    
}


- (id)initWithSupershape:(Shape*)theSuperShape andElementalShape:(Shape*)theElementalShape;

- (void)multiplicateSubshape;


@end
