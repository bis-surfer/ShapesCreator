//
//  EPCompoundObjectCell.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 19.02.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EditablePropertyTableViewCell.h"

#import "EditableObjectView.h"


@interface EPCompoundObjectCell : EditablePropertyTableViewCell {
    
    id<EditableObject> propertyValueObject;
    
    IBOutlet EditableObjectView *editableObjView;
}

@property (strong, nonatomic) id<EditableObject> propertyValueObject;

@property (strong, nonatomic) IBOutlet EditableObjectView *editableObjView;


@end
