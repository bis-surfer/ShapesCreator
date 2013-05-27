//
//  ArrangedDataObjectsCollectionVC.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 01.03.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "ArrangedDataObjectsCollectionVC.h"
#import "AppDelegate.h"


#define BG_VIEW       1
#define ICON_IMVIEW   2
#define TITLE_TEXTF   3
#define DESCR_LABEL   4

#define TITLE_FOLDER_ALERT_TAG 17
#define OBJECT_RESTORED_ALERT_TAG 24

#define AS_FOR_FOLDER 21
#define AS_FOR_TRASH  23

#define AS_FOR_FOLDER_BTN_TTL_RENAME    @"Rename"
#define AS_FOR_FOLDER_BTN_TTL_MOVE      @"Move"
#define AS_FOR_TRASH_BTN_TTL_EMPTYTRASH @"Empty Trash"


@implementation ArrangedDataObjectsCollectionVC

@synthesize collection;
@synthesize folderTitleLbl;
@synthesize generalTableView;
@synthesize theCell;
@synthesize mainBtn;
@synthesize folderTitleTxtFld;
@synthesize folderToBeChanged;
@synthesize cellToPerformActionWithIt;
@synthesize itemToPerformActionOnIt;
@synthesize delegate;

- (NSString*)cellForFolderIdentifier {
    
    if ([AppDelegate isiPad]) {
        
        return @"FolderCell-iPad";
    }
    
    return @"FolderCell";
}

- (NSString*)cellForTrashIdentifier {
    
    if ([AppDelegate isiPad]) {
        
        return @"TrashCell-iPad";
    }
    
    return @"TrashCell";
}

- (Folder*)ascendToSuperfolder {
    
    [collection ascendToSuperfolder];
    
    folderTitleLbl.text = collection.currentFolder.title;
    
    if ([collection areCurrentlyInRootFolder]) {
        mainBtn.title = @"Main";
    }
    else {
        mainBtn.title = [collection truncatedSuperfolderTitleForInterfaceOrientation:self.interfaceOrientation];
    }
    
    [generalTableView reloadData];
    
    return collection.currentFolder;
}

- (Folder*)descentToSubfolder:(Folder*)subfolder {
    
    [collection descentToSubfolder:subfolder];
    
    folderTitleLbl.text = collection.currentFolder.title;
    mainBtn.title = [collection truncatedSuperfolderTitleForInterfaceOrientation:self.interfaceOrientation];
    
    [generalTableView reloadData];
    
    return collection.currentFolder;
}

#pragma mark - IBActions 

- (IBAction)done:(id)sender {
    
    [self terminateTxtFldEditing];
}

- (IBAction)addFolder:(id)sender {
    
    [self terminateTxtFldEditing];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Enter new folder title" message:@"  \n " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    folderTitleTxtFld = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 50.0, 245.0, 25.0)];
    folderTitleTxtFld.backgroundColor = [UIColor whiteColor];
    folderTitleTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
    folderTitleTxtFld.keyboardAppearance = UIKeyboardAppearanceAlert;
    folderTitleTxtFld.returnKeyType = UIReturnKeyDone;
    [folderTitleTxtFld becomeFirstResponder];
    
    [alertView addSubview:folderTitleTxtFld];
    [alertView setTransform:CGAffineTransformMakeTranslation(0.0, -25.0)];
    
    alertView.tag = TITLE_FOLDER_ALERT_TAG;
    
    [alertView show];
}

#pragma mark - custom general methods 

- (void)openFolder:(Folder*)folder {
    
    [self descentToSubfolder:folder];
}

- (void)renameFolder:(Folder*)folder atCell:(UITableViewCell*)cell {
    
    UITextField *titleTxtFld = (UITextField*)[cell viewWithTag:TITLE_TEXTF];
    if (!self.folderTitleTxtFld) {
        self.folderTitleTxtFld = titleTxtFld;
        self.folderToBeChanged = folder;
        folderTitleTxtFld.enabled = YES;
        folderTitleTxtFld.borderStyle = UITextBorderStyleRoundedRect;
        [folderTitleTxtFld becomeFirstResponder];
    }
    else {
        [self terminateTxtFldEditing];
    }
}

- (void)moveFolder:(Folder*)folder {
    
    [self moveItem:folder];
}

- (void)moveItem:(id)itemToMove {
    
    [self terminateTxtFldEditing];
    
    if (!self.canAddUpperView) return;
    FoldersTreeVC *foldersTreeVC = [[FoldersTreeVC alloc] initWithDataObjectsCollection:collection andItemToMove:itemToMove];
    [self registerDoneHandler:@selector(didObtainFoldersTreeVCDoneNotification:) forNotificationNamed:@"FoldersTreeVC_Done_Notification" sentByUpperVC:foldersTreeVC];
}

- (void)openTrash {
    
    if (!isInEditingMode) {
        
        [generalTableView setEditing:YES animated:YES];
    }
    
    [self descentToSubfolder:collection.trash];
}

- (void)exitTrash {
    
    [self ascendToSuperfolder];
    
    if (isInEditingMode) {
        mainBtn.title = @"Done";
    }
    else {
        [generalTableView setEditing:NO animated:YES];
    }
}

#pragma mark - custom subordinate methods 

- (void)moveItemAsDefinedAtFoldersTreeVC:(FoldersTreeVC*)ftreeVC {
    
    Folder *folderToMoveInto = ftreeVC.selectedFolder;
    id itemToMove = ftreeVC.itemToMove;
    BOOL move = YES;
    
    if (move && [folderToMoveInto isEqual:collection.currentFolder]) {
        
        return;
    }
    
    if ([itemToMove isKindOfClass:[Folder class]]) {
        
        [folderToMoveInto addSubfolder:itemToMove];
        if (move) {
            [collection.currentFolder removeSubfolder:itemToMove];
        }
    }
    else {
        
        [folderToMoveInto addDataObject:itemToMove];
        if (move) {
            [collection.currentFolder removeDataObject:itemToMove inSubfoldersAlso:NO];
        }
    }
    
	[generalTableView reloadData];
    
    if ([collection areCurrentlyInTrash]) {
        
        NSString *objectDescription = nil;
        
        if ([itemToMove isKindOfClass:[Folder class]]) {
            
            Folder *folder = (Folder*)itemToMove;
            objectDescription = [NSString stringWithFormat:@"Folder \"%@\"", folder.title];
        }
        else {
            
            objectDescription = [itemToMove dataObjectDescription];
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ was successfully restored", objectDescription] message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        alertView.tag = OBJECT_RESTORED_ALERT_TAG;
        
        [alertView show];
    }
}

- (void)didObtainFoldersTreeVCDoneNotification:(NSNotification *)notification {
    
    [self moveItemAsDefinedAtFoldersTreeVC:[notification object]];
    
    [self handleDoneNotification:notification];
}

- (void)setMainBtnWidthAndTitleForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    double mulptiplier = 1.0;
    if ([AppDelegate isiPad]) {
        mulptiplier *= 2.0;
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        mainBtn.width = 128.0*mulptiplier;
    }
    else {
        
        mainBtn.width = 64.0*mulptiplier;
    }
    if (!([mainBtn.title isEqual:@"Main"] || [mainBtn.title isEqual:@"Done"])) {
        
        mainBtn.title = [collection truncatedSuperfolderTitleForInterfaceOrientation:interfaceOrientation];
    }
}

- (void)terminateTxtFldEditing {
    
    if (self.folderTitleTxtFld) {
        
        [folderTitleTxtFld resignFirstResponder];
        folderTitleTxtFld.text = folderToBeChanged.title;
        folderTitleTxtFld.enabled = NO;
        folderTitleTxtFld.borderStyle = UITextBorderStyleNone;
        self.folderTitleTxtFld = nil;
        self.folderToBeChanged = nil;
    }
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    folderTitleLbl.text = collection.currentFolder.title;
    
    generalTableView.allowsSelectionDuringEditing = YES;
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [nc addObserver:self selector:@selector(willRotateHandler) name:@"WillRotateFromInterfaceOrientation_Notification" object:nil];    
    [nc addObserver:self selector:@selector(didRotateHandler) name:@"DidRotateFromInterfaceOrientation_Notification" object:nil];
}

- (void)willRotateHandler {
    
    urgeSlidingBackAndSkipSlidingUpwards = YES;
}

- (void)didRotateHandler {
    
    [self slideCellUpwards];
}

#pragma mark -
#pragma mark UIAlertViewDelegate Protocol methods 

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == TITLE_FOLDER_ALERT_TAG) {
        
        if (buttonIndex) {
            [collection.currentFolder addSubfolderTitled:[folderTitleTxtFld text]];
            [generalTableView reloadData];
        }
        
        self.folderTitleTxtFld = nil;
    }
    
    if (alertView.tag == OBJECT_RESTORED_ALERT_TAG) {
        
        if (![collection.trash hasContents]) {
            
            [self exitTrash];
        }
    }
}

#pragma mark - 
#pragma mark UITableViewDataSource Protocol auxiliary methods 

- (NSInteger)builtInFolderSection {
    
    return 0;
}

- (NSInteger)subfoldersSection {
    
    return 1;
}

- (NSInteger)dataObjectsSection {
    
    return 2;
}

- (NSInteger)trashSection {
    
    return 3;
}

- (UITableViewCell *)createCellRepresentingFolderForRowAtIndexPath:(NSIndexPath *)indexPath withIdentifier:(NSString *)cellIdentifier {
    
    [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    // Field 'theCell' is returned by this method and retained by the setter
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(obtainedLongPressOnFolder:)];
    [self.theCell addGestureRecognizer:longPressGesture];
    
    return self.theCell;
}

- (void)configureCell:(UITableViewCell *)cell representingFolder:(Folder *)folder forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIView *bgView = (UIView*)[cell viewWithTag:BG_VIEW];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UITextField *titleTxtFld = (UITextField*)[cell viewWithTag:TITLE_TEXTF];
    titleTxtFld.text = folder.title;
    titleTxtFld.enabled = NO;
    titleTxtFld.borderStyle = UITextBorderStyleNone;
    
    UIImageView *iconImView = (UIImageView*)[cell viewWithTag:ICON_IMVIEW];
    if ([folder hasContents]) {
        iconImView.image = [UIImage imageNamed:@"fs_folder_full@2x.png"];
    }
    else {
        iconImView.image = [UIImage imageNamed:@"fs_folder_empty@2x.png"];
    }
    
    UILabel *descrLbl = (UILabel*)[cell viewWithTag:DESCR_LABEL];
    NSString* dataObjectType = nil;
    if ([folder.data_objects count] > 0) {
        dataObjectType = [[folder.data_objects objectAtIndex:0] dataObjectType];
    }
    else {
        dataObjectType = @"";
    }
    [descrLbl setText:[folder describeContentsUsingDataObjectType:dataObjectType]];
}

- (UITableViewCell *)cellRepresentingFolder:(Folder *)folder forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = self.cellForFolderIdentifier;
    
    UITableViewCell *cell = [generalTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [self createCellRepresentingFolderForRowAtIndexPath:indexPath withIdentifier:cellIdentifier];
    }
	
    [self configureCell:cell representingFolder:folder forRowAtIndexPath:indexPath];
    
    return cell;
}

- (UITableViewCell *)createCellRepresentingTrashForRowAtIndexPath:(NSIndexPath *)indexPath withIdentifier:(NSString *)cellIdentifier {
    
    [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    // Field 'theCell' is returned by this method and retained by the setter
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(obtainedLongPressOnTrash:)];
    [self.theCell addGestureRecognizer:longPressGesture];
    
    return self.theCell;
}

- (void)configureCell:(UITableViewCell *)cell representingTrashForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIView *bgView = (UIView*)[cell viewWithTag:BG_VIEW];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconImView = (UIImageView*)[cell viewWithTag:ICON_IMVIEW];
    if ([collection.trash hasContents]) {
        iconImView.image = [UIImage imageNamed:@"fs_trash_full@2x.png"];
    }
    else {
        iconImView.image = [UIImage imageNamed:@"fs_trash_empty@2x.png"];
    }
    
    UILabel *descrLbl = (UILabel*)[cell viewWithTag:DESCR_LABEL];
    NSString* dataObjectType = nil;
    if ([collection.trash.data_objects count] > 0) {
        dataObjectType = [[collection.trash.data_objects objectAtIndex:0] dataObjectType];
    }
    else {
        dataObjectType = @"";
    }
    [descrLbl setText:[collection.trash describeContentsUsingDataObjectType:dataObjectType]];
}

- (UITableViewCell *)cellRepresentingTrashForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = self.cellForTrashIdentifier;
    
    UITableViewCell *cell = [generalTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [self createCellRepresentingTrashForRowAtIndexPath:indexPath withIdentifier:cellIdentifier];
    }
	
    [self configureCell:cell representingTrashForRowAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol methods 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == self.builtInFolderSection) {
        
        return collection.displayedBuiltInFolderCount;
    }
    if (section == self.subfoldersSection) {
        
        return collection.displayedSubfoldersCount;
    }
    if (section == self.dataObjectsSection) {
        
        return collection.displayedDataObjectsCount;
    }
    if (section == self.trashSection) {
        
        return collection.displayedTrashCount;
    }
    
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.builtInFolderSection) {
        
        Folder *folder = collection.builtInFolder;
        return [self cellRepresentingFolder:folder forRowAtIndexPath:indexPath];
    }
    if (indexPath.section == self.subfoldersSection) {
        
        Folder *folder = [collection displayedSubfolderAtIndex:indexPath.row];
        return [self cellRepresentingFolder:folder forRowAtIndexPath:indexPath];
    }
    if (indexPath.section == self.dataObjectsSection) {
        
        id dataObject = [collection.currentFolder dataObjectAtIndex:indexPath.row];
        return [self.delegate cellRepresentingDataObject:dataObject forRowAtIndexPath:indexPath];
    }
    if (indexPath.section == self.trashSection) {
        
        return [self cellRepresentingTrashForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.builtInFolderSection) {
        
        return;
    }
    if (indexPath.section == self.subfoldersSection) {
        
        Folder *folder = [collection displayedSubfolderAtIndex:indexPath.row];
        
        if ([collection areCurrentlyInTrash]) {
            // restoring item from the trash
            
            [self moveItem:folder];
            return;
        }
        
        if (collection.trash) {
            [collection.trash addSubfolder:folder];
        }
        else {
            [folder clear];
        }
        [collection.currentFolder removeSubfolder:folder];
    }
    if (indexPath.section == self.dataObjectsSection) {
        
        id dataObject = [collection displayedDataObjectAtIndex:indexPath.row];
        
        if ([collection areCurrentlyInTrash]) {
            // restoring item from the trash
            
            [self moveItem:dataObject];
            return;
        }
        
        if (collection.trash) {
            [collection.trash addDataObject:dataObject];
        }
        else {
            [dataObject freeDataObject];
        }
        [collection.currentFolder removeDataObject:dataObject inSubfoldersAlso:NO];
    }
    if (indexPath.section == self.trashSection) {
        
        return;
    }
    
    [generalTableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([collection areCurrentlyInBuiltInFolder]) {
        
        return NO;
    }
    if ([collection areCurrentlyInTrash]) {
        
        return NO;
    }
    
    if (indexPath.section == self.builtInFolderSection) {
        
        return NO;
    }
    if (indexPath.section == self.subfoldersSection) {
        
        return YES;
    }
    if (indexPath.section == self.dataObjectsSection) {
        
        return YES;
    }
    if (indexPath.section == self.trashSection) {
        
        return NO;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    if (fromIndexPath.section == self.subfoldersSection) {
        
        Folder *folder = [collection.currentFolder subfolderAtIndex:fromIndexPath.row];
        [collection.currentFolder.subfolders removeObjectAtIndex:fromIndexPath.row];
        [collection.currentFolder.subfolders insertObject:folder atIndex:toIndexPath.row];
    }
    if (fromIndexPath.section == self.dataObjectsSection) {
        
        id dataObject = [collection.currentFolder dataObjectAtIndex:fromIndexPath.row];
        [collection.currentFolder.data_objects removeObjectAtIndex:(fromIndexPath.row)];
        [collection.currentFolder.data_objects insertObject:dataObject atIndex:(toIndexPath.row)];
    }
}

#pragma mark - 
#pragma mark UITableViewDelegate Protocol methods 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.builtInFolderSection) {
        
        return 64.0;
    }
    if (indexPath.section == self.subfoldersSection) {
        
        return 64.0;
    }
    if (indexPath.section == self.dataObjectsSection) {
        
        id dataObject = [collection.currentFolder dataObjectAtIndex:indexPath.row];
        return [self.delegate heightForRowAtIndexPath:indexPath withDataObject:dataObject];
    }
    if (indexPath.section == self.trashSection) {
        
        return 64.0;
    }
    
    return 64.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.folderTitleTxtFld) {
        
        [self terminateTxtFldEditing];
        
        return;
    }
    
    if ([collection areCurrentlyInTrash]) {
        
        return;
    }
    
    if (indexPath.section == self.builtInFolderSection) {
        
        if (!isInEditingMode) {
            
            [self openFolder:collection.builtInFolder];
        }
    }
    else if (indexPath.section == self.subfoldersSection) {
        
        Folder *folder = [collection.currentFolder subfolderAtIndex:indexPath.row];
        
        if (isInEditingMode) {
            
            self.cellToPerformActionWithIt = [tableView cellForRowAtIndexPath:indexPath];
            [self invokeActionSheetForFolder];
        }
        else {
            
            [self openFolder:folder];
        }
    }
    else if (indexPath.section == self.dataObjectsSection) {
        
        [self terminateTxtFldEditing];
        
        id dataObject = [collection.currentFolder dataObjectAtIndex:indexPath.row];
        [self.delegate didSelectRowAtIndexPath:indexPath withDataObject:dataObject];
    }
    else if (indexPath.section == self.trashSection) {
        
        if (![collection.trash hasContents]) return;
        
        if (isInEditingMode) {
            
            [self invokeActionSheetForTrash];
        }
        else {
            
            [self openTrash];
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([collection areCurrentlyInTrash]) {
        
        return UITableViewCellEditingStyleInsert;
    }
    
    if (indexPath.section == self.builtInFolderSection) {
        
        return UITableViewCellEditingStyleNone;
    }
    else if (indexPath.section == self.subfoldersSection) {
        
        return UITableViewCellEditingStyleDelete;
    }
    else if (indexPath.section == self.dataObjectsSection) {
        
        id dataObject = [collection.currentFolder dataObjectAtIndex:indexPath.row];
        return [self.delegate editingStyleForRowAtIndexPath:indexPath withDataObject:dataObject];
    }
    else if (indexPath.section == self.trashSection) {
        
        return UITableViewCellEditingStyleNone;
    }
    
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

#pragma mark - ActionSheets invocations methods 

- (void)invokeActionSheetForFolder {
    
    NSIndexPath *indexPath = [self.generalTableView indexPathForCell:cellToPerformActionWithIt];
    
    if (indexPath.section == self.builtInFolderSection) {
        
        return;
    }
    else if (indexPath.section == self.subfoldersSection) {
        
        Folder *folder = (Folder*)self.itemToPerformActionOnIt;
        NSString *actionSheetTitle = [NSString stringWithFormat:@"Choose action to perform on folder \"%@\"", folder.title];
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:AS_FOR_FOLDER_BTN_TTL_RENAME, AS_FOR_FOLDER_BTN_TTL_MOVE, nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        actionSheet.tag = AS_FOR_FOLDER;
        [actionSheet showInView:self.view];
    }
}

- (void)invokeActionSheetForTrash {
    
    NSString *actionSheetTitle = [NSString stringWithFormat:@"Are you sure you want to empty trash?"];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:AS_FOR_TRASH_BTN_TTL_EMPTYTRASH otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    actionSheet.tag = AS_FOR_TRASH;
    [actionSheet showInView:self.view];
}

#pragma mark - LongPressGesture handling methods 

- (void)obtainedLongPressOnFolder:(UILongPressGestureRecognizer*)gesture {
    
    [self terminateTxtFldEditing];
    if (isInEditingMode || [collection areCurrentlyInTrash]) return;
    
    // Process only when gesture was just recognized, not when ended 
	if (gesture.state == UIGestureRecognizerStateBegan) {
        
		// get affected cell and its index path 
        self.cellToPerformActionWithIt = (UITableViewCell*)[gesture view];
        NSIndexPath *indexPath = [self.generalTableView indexPathForCell:cellToPerformActionWithIt];
        
        /*
        if (indexPath.section == self.builtInFolderSection) {
            
            return;
        }
        else 
         */
		if (indexPath.section == self.subfoldersSection) {
            
            self.itemToPerformActionOnIt = [collection.currentFolder itemAtIndex:indexPath.row];
            [self invokeActionSheetForFolder];
        }
	}
}

- (void)obtainedLongPressOnDataObject:(UILongPressGestureRecognizer*)gesture {
    
    [self terminateTxtFldEditing];
    if (isInEditingMode || [collection areCurrentlyInTrash]) return;
    
    // Process only when gesture was just recognized, not when ended 
	if (gesture.state == UIGestureRecognizerStateBegan) {
        
        // get affected cell and its index path 
        self.cellToPerformActionWithIt = (UITableViewCell*)[gesture view];
        NSIndexPath *indexPath = [self.generalTableView indexPathForCell:cellToPerformActionWithIt];
        
        if (indexPath.section == self.dataObjectsSection) {
            
            self.itemToPerformActionOnIt = [collection.currentFolder dataObjectAtIndex:indexPath.row];
            [self.delegate invokeActionSheetForDataObject];
        }
	}
}

- (void)obtainedLongPressOnTrash:(UILongPressGestureRecognizer*)gesture {
    
    [self terminateTxtFldEditing];
    if (isInEditingMode) return;
    
    if (![collection.trash hasContents]) return;
    
    // Process only when gesture was just recognized, not when ended 
	if (gesture.state == UIGestureRecognizerStateBegan) {
        
        [self invokeActionSheetForTrash];
	}
}

#pragma mark - UIActionSheetDelegate Protocol methods 

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if (actionSheet.tag == AS_FOR_FOLDER) {
        
        Folder *folder = (Folder*)itemToPerformActionOnIt;
        
        if ([buttonTitle isEqualToString:AS_FOR_FOLDER_BTN_TTL_RENAME]) {
            // Rename 
            // NSLog(@"Rename folder \"%@\"", folder.title);
            [self renameFolder:folder atCell:cellToPerformActionWithIt];
        }
        if ([buttonTitle isEqualToString:AS_FOR_FOLDER_BTN_TTL_MOVE]) {
            // Move 
            // NSLog(@"Move folder \"%@\"", folder.title);
            [self moveFolder:folder];
        }
        
        return;
    }
    
    if (actionSheet.tag == AS_FOR_TRASH) {
        
        /* if ([buttonTitle isEqualToString:AS_FOR_TRASH_BTN_TTL_EMPTYTRASH]) { */
        if (buttonIndex == actionSheet.destructiveButtonIndex) {
            // Empty trash 
            // NSLog(@"Empty trash");
            [collection.trash clear];
            
            [generalTableView reloadData];
        }
        
        return;
    }
}

#pragma mark - 
#pragma mark UITextFieldDelegate Protocol methods 

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.folderTitleTxtFld = textField;
    
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    self.folderToBeChanged.title = textField.text;
    [self terminateTxtFldEditing];
    
    return YES;
}

#pragma mark - 
#pragma mark Adjusting selected cell position in response to Keyboard showing/hiding 

- (void)shrinkGTVContentSize {
    
    generalTableView.contentSize = CGSizeMake(generalTableView.contentSize.width, generalTableView.contentSize.height - shiftUpwardsForGTVC);
}

- (void)slideCellUpwards {
    
    if (urgeSlidingBackAndSkipSlidingUpwards) {
        
        urgeSlidingBackAndSkipSlidingUpwards = NO;
        return;
    }
    
    UIView *cellContentView = folderTitleTxtFld.superview;
    UITableViewCell *cell = (UITableViewCell*)cellContentView.superview;
    NSIndexPath *indexPath = [generalTableView indexPathForCell:cell];
    NSUInteger index = indexPath.row;
    
    shiftUpwardsForGTVC = keyboardHeight - (generalTableView.frame.size.height - cell.frame.size.height*(index + 1) + generalTableView.contentOffset.y);
    
    if (shiftUpwardsForGTVC > 0) {
        
        generalTableView.contentSize = CGSizeMake(generalTableView.contentSize.width, generalTableView.contentSize.height + shiftUpwardsForGTVC);
        [generalTableView setContentOffset:CGPointMake(generalTableView.contentOffset.x, generalTableView.contentOffset.y + shiftUpwardsForGTVC) animated:YES];
    }
    else {
        shiftUpwardsForGTVC = 0;
    }
}

- (void)slideCellBack {
    
    if (urgeSlidingBackAndSkipSlidingUpwards) {
        
        [generalTableView setContentOffset:CGPointMake(generalTableView.contentOffset.x, generalTableView.contentOffset.y - shiftUpwardsForGTVC) animated:NO];
        [self shrinkGTVContentSize];
        
        return;
    }
    
    if (shiftUpwardsForGTVC > 0) {
        
        [generalTableView setContentOffset:CGPointMake(generalTableView.contentOffset.x, generalTableView.contentOffset.y - shiftUpwardsForGTVC) animated:YES];
        [self performSelector:@selector(shrinkGTVContentSize) withObject:nil afterDelay:0.3];
    }
}

- (void)adjustCellPositionUsingNotification:(NSNotification *)notification {
    
    if (!self.folderToBeChanged) {
        
        return;
    }
    
    NSValue *endingFrame = [[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame;
    [endingFrame getValue:&frame];
    keyboardHeight = (frame.size.width < frame.size.height) ? frame.size.width : frame.size.height;
    
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        
        [self slideCellUpwards];
    }
    else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
        
        [self slideCellBack];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    [self adjustCellPositionUsingNotification:notification];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    [self adjustCellPositionUsingNotification:notification];
}

@end
