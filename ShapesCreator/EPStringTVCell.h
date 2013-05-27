//
//  EPStringTVCell.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 30.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EditablePropertyTableViewCell.h"


@interface EPStringTVCell : EditablePropertyTableViewCell <UITextViewDelegate> {
    
    NSString *propertyValueString;
    IBOutlet UITextView *propertyValueTxtView;
}

@property (strong, nonatomic) NSString *propertyValueString;
@property (strong, nonatomic) IBOutlet UITextView *propertyValueTxtView;


- (void)setupWithPropertyValue:(NSString *)aPropertyValueString;


@end
