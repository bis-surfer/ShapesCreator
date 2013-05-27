//
//  ArrangedDataObjectsCollectionVC.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 01.03.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GeneralVC.h"

#import "ArrangedDataObjectsCollection.h"
#import "FoldersTreeVC.h"


@protocol ArrangedCollectionViewAndDataObjectHandlingDelegate <NSObject>

@required
- (NSString*)nibIdentifier;
- (NSString*)cellForDataObjectIdentifier;

- (UITableViewCell *)cellRepresentingDataObject:(id)dataObject forRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath withDataObject:(id)dataObject;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath withDataObject:(id)dataObject;
- (UITableViewCellEditingStyle)editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath withDataObject:(id)dataObject;

- (void)invokeActionSheetForDataObject;

@end


@interface ArrangedDataObjectsCollectionVC : GeneralVC <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate, UITextFieldDelegate> {
    
    ArrangedDataObjectsCollection *collection;
    
    IBOutlet UILabel *folderTitleLbl;
    IBOutlet UITableView *generalTableView;
    IBOutlet UITableViewCell *theCell;
    IBOutlet UIBarButtonItem *mainBtn;
    
    BOOL isInEditingMode;
    
    UITextField *folderTitleTxtFld;
    Folder *folderToBeChanged;
    
    CGFloat keyboardHeight;
    CGFloat shiftUpwardsForGTVC;
    BOOL urgeSlidingBackAndSkipSlidingUpwards;
    
    UITableViewCell *cellToPerformActionWithIt;
    id itemToPerformActionOnIt;
    
    id <ArrangedCollectionViewAndDataObjectHandlingDelegate> delegate;
}

@property (strong, nonatomic) ArrangedDataObjectsCollection *collection;
@property (strong, nonatomic) IBOutlet UILabel *folderTitleLbl;
@property (strong, nonatomic) IBOutlet UITableView *generalTableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *theCell;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *mainBtn;
@property (strong, nonatomic) UITextField *folderTitleTxtFld;
@property (strong, nonatomic) Folder *folderToBeChanged;
@property (strong, nonatomic) UITableViewCell *cellToPerformActionWithIt;
@property (nonatomic, retain) id itemToPerformActionOnIt;
@property (strong, nonatomic) id <ArrangedCollectionViewAndDataObjectHandlingDelegate> delegate;


- (NSString*)cellForFolderIdentifier;
- (NSString*)cellForTrashIdentifier;

- (Folder*)ascendToSuperfolder;
- (Folder*)descentToSubfolder:(Folder*)subfolder;

- (IBAction)done:(id)sender;
- (IBAction)addFolder:(id)sender;

- (void)openFolder:(Folder*)folder;
- (void)renameFolder:(Folder*)folder atCell:(UITableViewCell*)cell;
- (void)moveFolder:(Folder*)folder;
- (void)moveItem:(id)itemToMove;
- (void)openTrash;
- (void)exitTrash;

- (void)setMainBtnWidthAndTitleForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
- (void)terminateTxtFldEditing;
- (void)slideCellUpwards;
- (void)slideCellBack;

- (void)invokeActionSheetForFolder;
- (void)invokeActionSheetForTrash;

- (void)obtainedLongPressOnFolder:(UILongPressGestureRecognizer*)gesture;
- (void)obtainedLongPressOnDataObject:(UILongPressGestureRecognizer*)gesture;
- (void)obtainedLongPressOnTrash:(UILongPressGestureRecognizer*)gesture;


@end
