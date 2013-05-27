//
//  EPStringTVCell.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 30.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EPStringTVCell.h"


@implementation EPStringTVCell

@synthesize propertyValueString;
@synthesize propertyValueTxtView;

- (void)setupWithPropertyName:(NSString *)aPropertyName andValueObject:(id)aPropertyValueObject {
    
    [super setupWithPropertyName:aPropertyName andValueObject:aPropertyValueObject];
    
    [self setupWithPropertyValue:aPropertyValueObject];
}

- (void)setupWithPropertyValue:(NSString *)aPropertyValueString {
    
    self.propertyValueString = aPropertyValueString;
    self.propertyValueTxtView.text = self.propertyValueString;
}

- (void)updatePropertyValue {
    
    self.propertyValueString = self.propertyValueTxtView.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    self.propertyValueTxtView.editable = YES;
    [self.propertyValueTxtView becomeFirstResponder];
}

#pragma mark - UITextViewDelegate Protocol methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    [self updatePropertyValue];
    
    return YES;
}

@end
