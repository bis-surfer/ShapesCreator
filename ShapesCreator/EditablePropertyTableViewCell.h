//
//  EditablePropertyTableViewCell.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 18.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditablePropertyTableViewCell : UITableViewCell {
    
    IBOutlet UILabel *propertyNameLbl;
    IBOutlet UIView *customBackgroundView;
}

@property (strong, nonatomic) IBOutlet UILabel *propertyNameLbl;
@property (strong, nonatomic) IBOutlet UIView *customBackgroundView;


- (void)setupWithPropertyName:(NSString *)aPropertyName andValueObject:(id)aPropertyValueObject;


@end
