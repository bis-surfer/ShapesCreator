//
//  EPNumberCell.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 30.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EPNumberCell.h"


@implementation EPNumberCell

@synthesize propertyValueNumber;
@synthesize propertyValueTxtFld;

- (void)setupWithPropertyName:(NSString *)aPropertyName andValueObject:(id)aPropertyValueObject {
    
    [super setupWithPropertyName:aPropertyName andValueObject:aPropertyValueObject];
    
    [self setupWithPropertyValue:aPropertyValueObject];
}

- (void)setupWithPropertyValue:(NSNumber *)aPropertyValueNumber {
    
    self.propertyValueNumber = aPropertyValueNumber;
    self.propertyValueTxtFld.text = [self.propertyValueNumber stringValue];
}

- (void)updatePropertyValue {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    self.propertyValueNumber = [numberFormatter numberFromString:self.propertyValueTxtFld.text];
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
    
    return YES;
}

@end
