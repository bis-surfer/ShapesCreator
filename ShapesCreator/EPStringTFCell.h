//
//  EPStringTFCell.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 30.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EditablePropertyTableViewCell.h"


@interface EPStringTFCell : EditablePropertyTableViewCell <UITextFieldDelegate> {
    
    NSString *propertyValueString;
    IBOutlet UITextField *propertyValueTxtFld;
}

@property (strong, nonatomic) NSString *propertyValueString;
@property (strong, nonatomic) IBOutlet UITextField *propertyValueTxtFld;


- (void)setupWithPropertyValue:(NSString *)aPropertyValueString;


@end
