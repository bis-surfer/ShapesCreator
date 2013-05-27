//
//  ShapeEditVC.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 16.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GeneralVC.h"

#import "Shape.h"
#import "EditableObjectView.h"


@interface ShapeEditVC : GeneralVC {
    
    Shape *mainShape;
    
    IBOutlet UILabel *shapeTitleLbl;
    IBOutlet EditableObjectView *editableObjView;
    IBOutlet UIBarButtonItem *cancelBtn, *saveBtn;
}

@property (strong, nonatomic) Shape *mainShape;

@property (strong, nonatomic) IBOutlet UILabel *shapeTitleLbl;
@property (strong, nonatomic) IBOutlet EditableObjectView *editableObjView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelBtn, *saveBtn;

- (NSString*)nibIdentifier;

- (id)initWithShape:(Shape*)theShape;

- (IBAction)done:(id)sender;


@end
