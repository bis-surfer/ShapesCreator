//
//  ShapesCollectionVC.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 01.03.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "ShapesCollectionVC.h"

#import "AppDelegate.h"

#import "ShapeEditVC.h"


#define BG_VIEW       1
#define ICON_IMVIEW   2
#define TITLE_LABEL   3
#define DESCR_LABEL   4

#define AS_FOR_SHAPE   25
#define AS_ADD_SHAPE   71
#define AS_SHARE_SHAPE 73


@implementation ShapesCollectionVC

- (id)init {
    
    self.delegate = self;
    self = [super initWithNibName:self.delegate.nibIdentifier bundle:nil];
    
    if (self) {
        
        self.collection = ad.rep.shapesCollection;
        
        [self inAnimationWithStatusBarHiding:NO];
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)displayShape:(Shape*)shape {
    
    if (!self.canAddUpperView) return;
    ShapeVC *shapeVC = [[ShapeVC alloc] initWithShape:shape];
    [self registerDoneHandler:@selector(didObtainShapeVCDoneNotification:) forNotificationNamed:@"ShapeVC_Done_Notification" sentByUpperVC:shapeVC];
}

- (void)didObtainShapeVCDoneNotification:(NSNotification *)notification {
    
    [self handleDoneNotification:notification];
}

- (void)editShape:(Shape*)shape {
    
    if (!self.canAddUpperView) return;
    ShapeEditVC *shapeEditVC = [[ShapeEditVC alloc] initWithShape:shape];
    [self registerDoneHandler:@selector(didObtainShapeEditVCDoneNotification:) forNotificationNamed:@"ShapeEditVC_Done_Notification" sentByUpperVC:shapeEditVC];
}

- (void)didObtainShapeEditVCDoneNotification:(NSNotification *)notification {
    
    [self handleDoneNotification:notification];
}

- (void)moveShape:(Shape*)shape {
    
    [self moveItem:shape];
}

- (void)shareShape:(Shape*)shape {
    
}

#pragma mark - IBActions 

- (IBAction)done:(id)sender {
    
    [super done:sender];
    
    if ([collection areCurrentlyInTrash]) {
        
        [self exitTrash];
        
        return;
    }
    
    if (isInEditingMode) {   // Finished editing 
        
        isInEditingMode = NO;
        if ([collection areCurrentlyInRootFolder]) {
            mainBtn.title = @"Main";
        }
        else {
            mainBtn.title = [collection truncatedSuperfolderTitleForInterfaceOrientation:self.interfaceOrientation];
        }
        [generalTableView setEditing:NO animated:YES];
    }
    else {
        
        if ([collection areCurrentlyInRootFolder]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShapesCollectionVC_Done_Notification" object:self];
        }
        else {
            
            [self ascendToSuperfolder];
        }
    }
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    [self setMainBtnWidthAndTitleForInterfaceOrientation:interfaceOrientation];
    
    // Return YES for supported orientations
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

#pragma mark - ArrangedDataObjectsCollectionVC overriden methods 

- (void)obtainedLongPressOnDataObject:(UILongPressGestureRecognizer*)gesture {
    
    if (isInEditingMode || [collection areCurrentlyInBuiltInFolder] || [collection areCurrentlyInTrash]) {
        
        return;
    }
    
    [super obtainedLongPressOnDataObject:gesture];
}

#pragma mark - ArrangedDataObjectsCollectionVC.generalTableView related specific methods 

- (UITableViewCell *)createCellForRowAtIndexPath:(NSIndexPath *)indexPath withIdentifier:(NSString *)cellIdentifier {
    
    [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    // Field 'theCell' is returned by this method and retained by the setter
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(obtainedLongPressOnDataObject:)];
    [self.theCell addGestureRecognizer:longPressGesture];
    
    return self.theCell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withDataObject:(id)dataObject {
    
    Shape *shape = (Shape*)dataObject;
    
    if ([shape.subShapes count] > 0) {
        // that's compound shape
    }
    else {
        // that's single shape
    }
    
    UIView *bgView = (UIView*)[cell viewWithTag:BG_VIEW];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconIV = (UIImageView*)[cell viewWithTag:ICON_IMVIEW];
    iconIV.image = [UIImage imageNamed:shape.iconName];
    if (!iconIV.image) {
        
        if ([shape.subShapes count] > 0) {
            // that's compound shape
            iconIV.image = [UIImage imageNamed:@"shape_icon_CompoundShape.png"];
        }
        else {
            // that's single shape
            iconIV.image = [UIImage imageNamed:@"shape_icon_Default.png"];
        }
    }
    
    UILabel *titleLbl = (UILabel*)[cell viewWithTag:TITLE_LABEL];
    titleLbl.text = shape.title;
    
    UILabel *descrLbl = (UILabel*)[cell viewWithTag:DESCR_LABEL];
    descrLbl.text = [shape describeItself];
}

#pragma mark - ArrangedCollectionViewAndDataObjectHandlingDelegate Protocol methods

- (NSString*)nibIdentifier {
    
    if ([AppDelegate isiPad]) {
        
        return @"ShapesCollectionView-iPad";
    }
    
    return @"ShapesCollectionView";
}

- (NSString*)cellForDataObjectIdentifier {
    
    if ([AppDelegate isiPad]) {
        
        return @"ShapeCell-iPad";
    }
    
    return @"ShapeCell";
}

- (UITableViewCell *)cellRepresentingDataObject:(id)dataObject forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = self.delegate.cellForDataObjectIdentifier;
    
    UITableViewCell *cell = [generalTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [self createCellForRowAtIndexPath:indexPath withIdentifier:cellIdentifier];
    }
	
    [self configureCell:cell forRowAtIndexPath:indexPath withDataObject:dataObject];
    
    return cell;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath withDataObject:(id)dataObject {
    
    return 64.0;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath withDataObject:(id)dataObject {
    
    if (isInEditingMode) {
        
        self.itemToPerformActionOnIt = dataObject;
        
        [self invokeActionSheetForDataObject];
    }
    else {
        
        [self displayShape:dataObject];
    }
}

- (UITableViewCellEditingStyle)editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath withDataObject:(id)dataObject {
    
    if ([collection areCurrentlyInBuiltInFolder]) {
        
        return UITableViewCellEditingStyleNone;
    }
    
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - ActionSheet invocation method 

- (void)invokeActionSheetForDataObject {
    
    Shape *shape = self.itemToPerformActionOnIt;
    
    NSString *actionSheetTitle = [NSString stringWithFormat:@"Choose action to perform on shape \"%@\"", shape.title];
    UIActionSheet *actionSheet = nil;
    
    if (shape.isBuiltIn) {
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Display", @"Edit", nil];
    }
    else {
        
        if ([shape.subShapes count] > 0) {
            // that's compound shape 
        }
        else {
            // that's single shape 
        }
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Display", @"Edit", @"Move", @"Share", nil];
    }
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    actionSheet.tag = AS_FOR_SHAPE;
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate Protocol methods 

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [super actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
    
    if (actionSheet.tag == AS_FOR_SHAPE) {
        
        Shape *shape = self.itemToPerformActionOnIt;
        
        if (shape.isBuiltIn) {
            
            if (buttonIndex == actionSheet.firstOtherButtonIndex) {
                
                [self displayShape:shape];
            }
            if (buttonIndex == actionSheet.firstOtherButtonIndex + 1) {
                
                [self editShape:shape];
            }
        }
        else {
            
            if (buttonIndex == actionSheet.firstOtherButtonIndex) {
                
                [self displayShape:shape];
            }
            if (buttonIndex == actionSheet.firstOtherButtonIndex + 1) {
                
                [self editShape:shape];
            }
            if (buttonIndex == actionSheet.firstOtherButtonIndex + 2) {
                
                [self moveShape:shape];
            }
            if (buttonIndex == actionSheet.firstOtherButtonIndex + 3) {
                
                [self shareShape:shape];
            }
        }
        
        return;
    }
}

@end
