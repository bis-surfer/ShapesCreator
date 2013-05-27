//
//  SymmetricalShape.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 11.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "SymmetricalShape.h"


@implementation SymmetricalShape

- (id)initWithSupershape:(Shape*)theSuperShape andElementalShape:(Shape*)theElementalShape {
	
    self = [super initWithSupershape:theSuperShape];
    
    if (self) {
        
        self.title = @"Symmetrical Shape";
        self.iconName = @"shape_icon_SymmetricalShape.png";
        
        [subShapes addObject:theElementalShape];
    }
    
    return self;
}

- (void)multiplicateSubshape {
    
}

@end
