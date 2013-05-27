//
//  EPNumberCell.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 30.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EditablePropertyTableViewCell.h"


@interface EPNumberCell : EditablePropertyTableViewCell <UITextFieldDelegate> {
    
    NSNumber *propertyValueNumber;
    IBOutlet UITextField *propertyValueTxtFld;
}

@property (strong, nonatomic) NSNumber *propertyValueNumber;
@property (strong, nonatomic) IBOutlet UITextField *propertyValueTxtFld;


- (void)setupWithPropertyValue:(NSNumber *)aPropertyValueNumber;


@end
