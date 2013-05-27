//
//  ShapeStyle.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 14.02.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "ShapeStyle.h"


@implementation ShapeStyle

@synthesize fillColor;
@synthesize outlineColor;
@synthesize lineWidth;

- (id)init {
	
    self = [super init];
    
    if (self) {
        
        self.fillColor    = nil;   // [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
        self.outlineColor = [UIColor colorWithRed:0.5 green:0.0 blue:1.0 alpha:1.0];
        self.lineWidth    = 1.0;
    }
    
    return self;
}

- (CGColorRef)fillCGColor {
    
    return [fillColor CGColor];
}

- (CGColorRef)outlineCGColor {
    
    return [outlineColor CGColor];
}

#pragma mark - EditableObject Protocol methods

- (NSArray*)editableObjectTableViewData {
    
    EPTVCellDataSource *fillColorCellData = [[EPTVCellDataSource alloc] initWithCellIdentifier:@"EPColorCell" cellHeight:204.0 propertyName:@"Fill Color" andPropertyValueObject:self.fillColor];
    EPTVCellDataSource *outlineColorCellData = [[EPTVCellDataSource alloc] initWithCellIdentifier:@"EPColorCell" cellHeight:204.0 propertyName:@"Outline Color" andPropertyValueObject:self.outlineColor];
    EPTVCellDataSource *lineWidthCellData = [[EPTVCellDataSource alloc] initWithCellIdentifier:@"EPNumberCell" cellHeight:46.0 propertyName:@"Line Width" andPropertyValueObject:[NSNumber numberWithFloat:self.lineWidth]];
    
    NSArray *section0CellsData = [[NSArray alloc] initWithObjects:fillColorCellData, outlineColorCellData, lineWidthCellData, nil];
    
    return [[NSArray alloc] initWithObjects:section0CellsData, nil];
}

#pragma mark - NSCoding Protocol methods

// Returns an object initialized from data in a given unarchiver (required) 
// Parameters: decoder - an unarchiver object. 
// Return Value: self, initialized using the data in decoder. 
- (id)initWithCoder:(NSCoder *)decoder {
	
    self = [super init];
    
    if (self) {
        
        self.fillColor    = [decoder decodeObjectForKey:@"fillColor"];
        self.outlineColor = [decoder decodeObjectForKey:@"outlineColor"];
        self.lineWidth = (CGFloat)[decoder decodeFloatForKey:@"lineWidth"];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required) 
// Parameters: encoder - an archiver object. 
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:fillColor forKey:@"fillColor"];
    [encoder encodeObject:outlineColor forKey:@"outlineColor"];
    [encoder encodeFloat:(float)lineWidth forKey:@"lineWidth"];
}

@end
