//
//  EPCompoundObjectCell.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 19.02.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EPCompoundObjectCell.h"


@implementation EPCompoundObjectCell

@synthesize propertyValueObject;
@synthesize editableObjView;

- (void)setupWithPropertyName:(NSString *)aPropertyName andValueObject:(id)aPropertyValueObject {
    
    [super setupWithPropertyName:aPropertyName andValueObject:aPropertyValueObject];
    
    [self setupWithPropertyValue:aPropertyValueObject];
}

- (void)setupWithPropertyValue:(id<EditableObject>)aPropertyValueObject {
    
    self.propertyValueObject = aPropertyValueObject;
    editableObjView.obj = self.propertyValueObject;
}

@end
