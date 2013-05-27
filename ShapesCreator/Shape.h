//
//  Shape.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 18.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ShapeStyle.h"
#import "Transformation.h"

#import "DataObject.h"
#import "EditableObject.h"


@interface Shape : NSObject <DataObject, EditableObject, NSCoding> {
    
    NSString *title;                    // Title of the Shape 
    
    BOOL isBuiltIn;                     // Shows whether Shape is built-in Shape 
    
    NSString *creator;                  // Name of the Shape's creator 
    NSDate *dateOfCreation;             // Time at which the Shape was created 
    NSDate *dateOfLastModification;     // Time at which the Shape was last modified 
    NSString *description;              // Description of the Shape 
    
    NSString *iconName;                 // Name of image representing Shape in table view 
    
    ShapeStyle *style;
    NSMutableArray *transformations;
    
    NSMutableArray *multiplicateTransformations;
    Transformation *currentMultiplicatingTransformation;
    
    Transformation *shapeCsToScreenCsTransform;
    
    NSMutableArray *subShapes;
    
    Shape *superShape;
}

@property (strong, nonatomic) NSString *title;
@property (nonatomic) BOOL isBuiltIn;
@property (strong, nonatomic) NSString *creator;
@property (strong, nonatomic) NSDate *dateOfCreation;
@property (strong, nonatomic) NSDate *dateOfLastModification;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *iconName;
@property (strong, nonatomic) ShapeStyle *style;
@property (strong, nonatomic) NSMutableArray *transformations;
@property (strong, nonatomic) NSMutableArray *multiplicateTransformations;
@property (strong, nonatomic) Transformation *currentMultiplicatingTransformation;
@property (strong, nonatomic) Transformation *shapeCsToScreenCsTransform;
@property (strong, nonatomic) NSMutableArray *subShapes;
@property (strong, nonatomic) Shape *superShape;


- (id)initWithSupershape:(Shape*)theSuperShape;

- (void)populate;

// Method transforming the local Shape coordinates (in units) to the Screen Coordinates (in points) 
- (struct Coordinates)screenCsFromShapeCs:(struct Coordinates)shapeCs;

- (void)addTransformation:(Transformation*)t;
- (void)removeLastTransformation;

- (void)cloneWithTransformation:(Transformation*)multiplicatingTransformation;

- (void)applyTheSelfStyleForSubShapes;

- (NSString*)describeItself;

- (void)drawAtRect:(CGRect)rect;
- (void)drawElementWithTransformation:(Transformation*)multiplicatingTransformation AtRect:(CGRect)rect;

- (CGRect)dimensionsRectangle;


@end
