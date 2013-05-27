//
//  RotationNOrderSymmetricalShape.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 11.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "SymmetricalShape.h"


@interface RotationNOrderSymmetricalShape : SymmetricalShape {
    
    NSUInteger n;
}

@property (nonatomic) NSUInteger n;


- (id)initWithSupershape:(Shape*)theSuperShape elementalShape:(Shape*)theElementalShape andOrderOfSymmetry:(NSUInteger)theOrderOfSymmetry;


@end
