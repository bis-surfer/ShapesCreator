//
//  EPArrayCell.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 30.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EditablePropertyTableViewCell.h"


@interface EPArrayCell : EditablePropertyTableViewCell <UITableViewDataSource, UITableViewDelegate> {
    
    NSArray *propertyValueArray;
    
    IBOutlet UIView *arrayTitleView;
    IBOutlet UIButton *arrayAddItemBtn;
    IBOutlet UITableView *arrayTblView;
    IBOutlet EditablePropertyTableViewCell *theCell;
}

@property (strong, nonatomic) NSArray *propertyValueArray;

@property (strong, nonatomic) IBOutlet UIView *arrayTitleView;
@property (strong, nonatomic) IBOutlet UIButton *arrayAddItemBtn;
@property (strong, nonatomic) IBOutlet UITableView *arrayTblView;
@property (strong, nonatomic) IBOutlet EditablePropertyTableViewCell *theCell;


- (void)setupWithPropertyValue:(NSArray *)aPropertyValueArray;

- (IBAction)addItem:(id)sender;


@end
