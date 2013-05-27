//
//  EditablePropertyTableViewCell.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 18.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EditablePropertyTableViewCell.h"


@implementation EditablePropertyTableViewCell

@synthesize propertyNameLbl;
@synthesize customBackgroundView;

- (void)setupWithPropertyName:(NSString *)aPropertyName andValueObject:(id)aPropertyValueObject {
    
    self.propertyNameLbl.text = [NSString stringWithFormat:@"%@: ", aPropertyName];
}

@end
