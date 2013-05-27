//
//  EPStringTFCell.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 30.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EPStringTFCell.h"


@implementation EPStringTFCell

@synthesize propertyValueString;
@synthesize propertyValueTxtFld;

- (void)setupWithPropertyName:(NSString *)aPropertyName andValueObject:(id)aPropertyValueObject {
    
    [super setupWithPropertyName:aPropertyName andValueObject:aPropertyValueObject];
    
    [self setupWithPropertyValue:aPropertyValueObject];
}

- (void)setupWithPropertyValue:(NSString *)aPropertyValueString {
    
    self.propertyValueString = aPropertyValueString;
    self.propertyValueTxtFld.text = self.propertyValueString;
}

- (void)updatePropertyValue {
    
    self.propertyValueString = self.propertyValueTxtFld.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    self.propertyValueTxtFld.enabled = YES;
    [self.propertyValueTxtFld becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate Protocol methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    [self updatePropertyValue];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self updatePropertyValue];
    
    [textField resignFirstResponder];
    self.propertyValueTxtFld.enabled = NO;
    
    return YES;
}

@end
