//
//  EditableObjectView.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 27.02.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EditableObject.h"
#import "EditablePropertyTableViewCell.h"


@interface EditableObjectView : UIView <UITableViewDataSource, UITableViewDelegate> {
    
    id<EditableObject> obj;
    
    IBOutlet UIView *titleView;
    IBOutlet UIButton *resetBtn;
    IBOutlet UITableView *theTableView;
    IBOutlet EditablePropertyTableViewCell *theCell;
}

@property (strong, nonatomic) id<EditableObject> obj;
@property (strong, nonatomic) NSArray *tableViewData;

@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) IBOutlet UIButton *resetBtn;
@property (strong, nonatomic) IBOutlet UITableView *theTableView;
@property (strong, nonatomic) IBOutlet EditablePropertyTableViewCell *theCell;


- (CGFloat)tableViewHeight;

- (IBAction)reset:(id)sender;


@end
