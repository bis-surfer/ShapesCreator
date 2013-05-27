//
//  Shape.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 18.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "Shape.h"

#import "AppDelegate.h"


@implementation Shape

@synthesize title;
@synthesize isBuiltIn;
@synthesize creator;
@synthesize dateOfCreation;
@synthesize dateOfLastModification;
@synthesize description;
@synthesize iconName;
@synthesize style;
@synthesize transformations;
@synthesize multiplicateTransformations;
@synthesize currentMultiplicatingTransformation;
@synthesize shapeCsToScreenCsTransform;
@synthesize subShapes;
@synthesize superShape;

- (id)init {
    
    return [self initWithSupershape:nil];
}

- (id)initWithSupershape:(Shape*)theSuperShape {
	
    self = [super init];
    
    if (self) {
        
        self.title = nil;
        self.isBuiltIn = NO;
        self.creator = nil;
        self.dateOfCreation = nil;
        self.dateOfLastModification = nil;
        self.description = nil;
        self.iconName = @"shape_icon_Default.png";
        
        self.style = [[ShapeStyle alloc] init];
        self.transformations = [NSMutableArray array];
        
        Transformation *identicalTransformation = [[Transformation alloc] init];
        self.multiplicateTransformations = [NSMutableArray arrayWithObject:identicalTransformation];
        
        self.subShapes = [NSMutableArray array];
        self.superShape = theSuperShape;
    }
    
    return self;
}

- (void)populate {
    
}

// Method transforming the present (self) shape coordinates to the superShape coordinates 
- (struct Coordinates)supershapeCsFromShapeCs:(struct Coordinates)shapeCs {
    
    struct Coordinates C = shapeCs;
    
    for (Transformation *transform in transformations) {
        
        C = [transform transformedCoordinatesFromOriginalCoordinates:C];
    }
    
    C = [currentMultiplicatingTransformation transformedCoordinatesFromOriginalCoordinates:C];
    
    return C;
}

// Method transforming the local Shape coordinates (in units) to the Screen Coordinates (in points) 
- (struct Coordinates)screenCsFromShapeCs:(struct Coordinates)shapeCs {
    
    struct Coordinates C = shapeCs;
    Shape *transformingShape = self;
    
    while (transformingShape) {
        
        C = [transformingShape supershapeCsFromShapeCs:C];
        self.shapeCsToScreenCsTransform = transformingShape.shapeCsToScreenCsTransform;
        transformingShape = transformingShape.superShape;
    }
    
    C = [shapeCsToScreenCsTransform transformedCoordinatesFromOriginalCoordinates:C];
    
    return C;
}

- (void)addTransformation:(Transformation*)t {
    
    [transformations addObject:t];
}

- (void)removeLastTransformation {
    
    [transformations removeLastObject];
}

- (void)cloneWithTransformation:(Transformation*)multiplicatingTransformation {
    
    [multiplicateTransformations addObject:multiplicatingTransformation];
}

- (void)applyTheSelfStyleForSubShapes {
    
    for (Shape *shape in subShapes) {
        
        shape.style = self.style;
        
        [shape applyTheSelfStyleForSubShapes];
    }
}

- (NSString*)describeItself {
    
    NSString *selfDescription = @"";
    NSUInteger numberOfSubShapes = [subShapes count];
    if (numberOfSubShapes > 0) {
        selfDescription = [NSString stringWithFormat:@"compound: %u subshape", numberOfSubShapes];
        if (numberOfSubShapes > 1) {
            selfDescription = [selfDescription stringByAppendingString:@"s"];
        }
        if (description.length > 0) {
            selfDescription = [selfDescription stringByAppendingFormat:@"; %@", description];
        }
    }
    else {
        selfDescription = [NSString stringWithFormat:@"single"];
    }
    return selfDescription;
}

- (void)drawAtRect:(CGRect)rect {
    
    for (Transformation *multiplicatingTransformation in multiplicateTransformations) {
        
        [self drawElementWithTransformation:multiplicatingTransformation AtRect:rect];
    }
}

- (void)drawElementWithTransformation:(Transformation*)multiplicatingTransformation AtRect:(CGRect)rect {
    
    self.currentMultiplicatingTransformation = multiplicatingTransformation;
    
    for (Shape *shape in subShapes) {
        
        [shape drawAtRect:rect];
    }
}

- (CGRect)dimensionsRectangle {
    
    return CGRectMake(-6.0, -6.0, 12.0, 12.0);
}

#pragma mark - DataObject Protocol methods

- (NSString*)dataObjectType {
    
    return @"shape";
}

- (NSString*)dataObjectDescription {
    
    return [NSString stringWithFormat:@"Shape \"%@\"", self.title];
}

- (void)freeDataObject {
    
    // TODO: Perform removal of locally stored files bound to dataObjects (if any) 
}

#pragma mark - EditableObject Protocol methods 

- (NSArray*)editableObjectTableViewData {
    
    EPTVCellDataSource *titleCellData = [[EPTVCellDataSource alloc] initWithCellIdentifier:@"EPStringTFCell" cellHeight:46.0 propertyName:@"Title" andPropertyValueObject:self.title];
    EPTVCellDataSource *creatorCellData = [[EPTVCellDataSource alloc] initWithCellIdentifier:@"EPStringTFCell" cellHeight:46.0 propertyName:@"Creator" andPropertyValueObject:self.creator];
    EPTVCellDataSource *descriptionCellData = [[EPTVCellDataSource alloc] initWithCellIdentifier:@"EPStringTVCell" cellHeight:80.0 propertyName:@"Description" andPropertyValueObject:self.description];
    
    NSArray *section0CellsData = [[NSArray alloc] initWithObjects:titleCellData, creatorCellData, descriptionCellData, nil];
    
    EPTVCellDataSource *subShapesCellData = [[EPTVCellDataSource alloc] initWithCellIdentifier:@"EPArrayCell" cellHeight:(44.0 + 46.0*[self.subShapes count]) propertyName:@"Subshapes" andPropertyValueObject:self.subShapes];
    
    NSArray *section1CellsData = [[NSArray alloc] initWithObjects:subShapesCellData, nil];
    
    EPTVCellDataSource *styleCellData = [[EPTVCellDataSource alloc] initWithCellIdentifier:@"EPCompoundObjectCell" cellHeight:0.0 propertyName:@"Style" andPropertyValueObject:self.style];
    
    NSArray *section2CellsData = [[NSArray alloc] initWithObjects:styleCellData, nil];
    
    EPTVCellDataSource *transformationsCellData = [[EPTVCellDataSource alloc] initWithCellIdentifier:@"EPArrayCell" cellHeight:(44.0 + 46.0*[self.transformations count]) propertyName:@"Transformations" andPropertyValueObject:self.transformations];
    
    NSArray *section3CellsData = [[NSArray alloc] initWithObjects:transformationsCellData, nil];
    
    EPTVCellDataSource *multiplicateTransformationsCellData = [[EPTVCellDataSource alloc] initWithCellIdentifier:@"EPArrayCell" cellHeight:(44.0 + 46.0*[self.multiplicateTransformations count]) propertyName:@"Multiplicate Transformations" andPropertyValueObject:self.multiplicateTransformations];
    
    NSArray *section4CellsData = [[NSArray alloc] initWithObjects:multiplicateTransformationsCellData, nil];
    
    return [[NSArray alloc] initWithObjects:section0CellsData, section1CellsData, section2CellsData, section3CellsData, section4CellsData, nil];
}

#pragma mark - NSCoding Protocol methods

// Returns an object initialized from data in a given unarchiver (required) 
// Parameters: decoder - an unarchiver object. 
// Return Value: self, initialized using the data in decoder. 
- (id)initWithCoder:(NSCoder *)decoder {
	
    self = [super init];
    
    if (self) {
        
        self.title = [decoder decodeObjectForKey:@"title"];
        self.isBuiltIn = [decoder decodeBoolForKey:@"isBuiltIn"];
        
        self.creator = [decoder decodeObjectForKey:@"creator"];
        self.dateOfCreation = [decoder decodeObjectForKey:@"dateOfCreation"];
        self.dateOfLastModification = [decoder decodeObjectForKey:@"dateOfLastModification"];
        self.description = [decoder decodeObjectForKey:@"description"];
        
        self.iconName = [decoder decodeObjectForKey:@"iconName"];
        
        self.style = [decoder decodeObjectForKey:@"style"];
        self.transformations = [decoder decodeObjectForKey:@"transformations"];
        
        self.multiplicateTransformations = [decoder decodeObjectForKey:@"multiplicateTransformations"];
        
        self.subShapes = [decoder decodeObjectForKey:@"subShapes"];
        
        // self.superShape = [decoder decodeObjectForKey:@"superShape"];
        
        // instead of decoding superShape let's use this snippet - 
        // and superShape will care about setting corresponding property to its subShapes --- > 
        for (Shape *subshape in subShapes) {
            
            subshape.superShape = self;
        }
        
        self.superShape = nil;
        // < --- 
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required) 
// Parameters: encoder - an archiver object. 
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:title forKey:@"title"];
    [encoder encodeBool:isBuiltIn forKey:@"isBuiltIn"];
    
    [encoder encodeObject:creator forKey:@"creator"];
    [encoder encodeObject:dateOfCreation forKey:@"dateOfCreation"];
    [encoder encodeObject:dateOfLastModification forKey:@"dateOfLastModification"];
    [encoder encodeObject:description forKey:@"description"];
    
    [encoder encodeObject:iconName forKey:@"iconName"];
    
    [encoder encodeObject:style forKey:@"style"];
    [encoder encodeObject:transformations forKey:@"transformations"];
    
    [encoder encodeObject:multiplicateTransformations forKey:@"multiplicateTransformations"];
    
    [encoder encodeObject:subShapes forKey:@"subShapes"];
    
    // [encoder encodeObject:superShape forKey:@"superShape"];
}

@end
