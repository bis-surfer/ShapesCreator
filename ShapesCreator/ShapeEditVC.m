//
//  ShapeEditVC.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 16.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "ShapeEditVC.h"

#import "AppDelegate.h"


/*
@interface ShapeEditVC ()

@property (strong, nonatomic) UIResponder *firstResponder;


@end
 */


@implementation ShapeEditVC

@synthesize mainShape;
@synthesize shapeTitleLbl;
@synthesize editableObjView;
@synthesize cancelBtn, saveBtn;

- (NSString*)nibIdentifier {
    
    if ([AppDelegate isiPad]) {
        
        return @"ShapeEditView-iPad";
    }
    
    return @"ShapeEditView";
}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

- (id)initWithShape:(Shape*)theShape {
    
    self = [super initWithNibName:self.nibIdentifier bundle:nil];
    
    if (self) {
        
        self.mainShape = theShape;
        
        [self inAnimationWithStatusBarHiding:NO];
    }
    
    return self;
}

- (IBAction)done:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShapeEditVC_Done_Notification" object:self];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    shapeTitleLbl.text = mainShape.title;
    editableObjView.obj = mainShape;
}

@end
