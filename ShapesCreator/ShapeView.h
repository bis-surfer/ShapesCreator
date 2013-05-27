//
//  ShapeView.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 18.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Shape.h"

#import "Transformation.h"
#import "AffineTransformation.h"


@interface ShapeView : UIView 

// Value of shape coordinates unit (points) 
@property (nonatomic) CGFloat unit;

// Center of (device) screen at shape coordinates (units) 
@property (nonatomic) CGPoint screenCenter;

@property (strong, nonatomic) AffineTransformation *mainShape_ShapeCsToScreenCsTransform;

@property (strong, nonatomic) Shape *mainShape;


- (void)setupUnitAndScreenCenter;

- (void)addDoubleTapGR;
- (void)addTwoTouchesTapGR;


@end
