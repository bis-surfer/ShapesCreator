//
//  FoldersTreeVC.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 02.03.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "FoldersTreeVC.h"


#define BG_VIEW         1
#define FOLDER_IMVIEW   2
#define TITLE_LABEL     3
#define SELECTED_IMVIEW 4


@implementation FoldersTreeVC

@synthesize collection;
@synthesize selectedFolder;
@synthesize itemToMove;
@synthesize foldersStructureTableView, theCell;
@synthesize doneBtn;

- (NSString*)nibIdentifier {
    
    return @"FoldersTreeView";
}

- (NSString*)cellIdentifier {
    
    return @"FoldersTreeCell";
}

- (id)initWithDataObjectsCollection:(ArrangedDataObjectsCollection*)theDataObjectsCollection andItemToMove:(id)theItemToMove {
    
    self = [super initWithNibName:self.nibIdentifier bundle:nil];
    
    if (self) {
        
        self.collection = theDataObjectsCollection;
        
        if ([collection areCurrentlyInTrash]) {
            
            self.selectedFolder = collection.rootFolder;
        }
        else {
            
            self.selectedFolder = collection.currentFolder;
        }
        
        self.itemToMove = theItemToMove;
        indexOfFolderToMove = NSNotFound;
        countToOmit = 0;
        if ([itemToMove isKindOfClass:[Folder class]]) {
            
            Folder *folderToMove = (Folder*)itemToMove;
            
            indexOfFolderToMove = [collection.rootFolder indexOfFolder:folderToMove];
            countToOmit = [folderToMove allFoldersCount];
        }
        
        [self inAnimationWithStatusBarHiding:NO];
    }
    
	return self;
}

- (IBAction)done:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FoldersTreeVC_Done_Notification" object:self];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - Some custom subordinate methods 

- (CGFloat)scaleForLevel:(NSUInteger)level {
    
    double fi = 0.5*(1.0 + sqrt(5.0));
    CGFloat scalingFactor = 1.0/sqrt(fi);
    CGFloat scale1 = exp(log(scalingFactor)*level);
    CGFloat scale2 = exp((1.0 - scale1)*log(0.5));
    
    return scale2;
}

- (Folder*)folderForRow:(NSInteger)row {
    
    if (row >= indexOfFolderToMove) {
        row += countToOmit;
    }
    
    return [collection.rootFolder folderAtIndex:row];
}

#pragma mark - 
#pragma mark UITableViewDataSource Protocol methods 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    
    NSInteger numberOfConsideredFolders = [collection.rootFolder allFoldersCount];
    
    if ([itemToMove isKindOfClass:[Folder class]]) {
        
        Folder *folderToMove = (Folder*)itemToMove;
        
        numberOfConsideredFolders -= [folderToMove allFoldersCount];
    }
    
    return numberOfConsideredFolders;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Folder *folder = [self folderForRow:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (cell == nil) {
        
        [[NSBundle mainBundle] loadNibNamed:self.cellIdentifier owner:self options:nil];
        // Field 'theCell' is returned by this method and retained by the setter 
        
        cell = theCell;
        self.theCell = nil;
    }
    
    // Configure the cell... --- > 
    
    UIView *bgView = (UIView*)[cell viewWithTag:BG_VIEW];
    
    if ([folder isEqual:collection.currentFolder]) {
        bgView.backgroundColor = [UIColor colorWithHue:0.3f saturation:0.00f brightness:0.92f alpha:1.0f];
    }
    else {
        bgView.backgroundColor = [UIColor whiteColor];
    }
    
    
    UIImageView *folderIView = (UIImageView*)[cell viewWithTag:FOLDER_IMVIEW];
    
    NSUInteger folderLevelInTree = [folder levelInTree];
    
    CGFloat rootImViewWidth = 40.0;
    CGFloat shift = 0.0;
    for (NSUInteger l = 1; l <= folderLevelInTree; l++) {
        shift += [self scaleForLevel:(l-1)];
    }
    double fi1 = 0.5*(sqrt(5.0) - 1.0);
    shift *= fi1*fi1*rootImViewWidth;
    // CGFloat scale = [self scaleForLevel:folderLevelInTree];
    
    CGAffineTransform t = CGAffineTransformMakeTranslation(shift, 0.0);
    // t = CGAffineTransformScale(t, scale, scale);
    
    folderIView.transform = t;
    
    NSUInteger iconLevel = folderLevelInTree;
    if (iconLevel > 3) {iconLevel = 3;}
    if (iconLevel == 0) {
        folderIView.image = [UIImage imageNamed:@"fs_folder_empty@2x"];
    }
    else {
        folderIView.image = [UIImage imageNamed:[NSString stringWithFormat:@"fs_folder%u@2x.png", iconLevel]];
    }
    
    
    // shift -= 0.5*rootImViewWidth*(1.0 - scale);
    UILabel *titleLabel = (UILabel*)[cell viewWithTag:TITLE_LABEL];
    if (CGAffineTransformIsIdentity(titleLabel.transform)) {
        titleLabel.frame = CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y, titleLabel.frame.size.width - shift, titleLabel.frame.size.height);
        titleLabel.transform = t;
    }
    [titleLabel setText:folder.title];
    
    
    UIImageView *selectedIView = (UIImageView*)[cell viewWithTag:SELECTED_IMVIEW];
    if ([folder isEqual:selectedFolder]) {
        selectedIView.hidden = NO;
    }
    else {
        selectedIView.hidden = YES;
    }
    // < --- Configure the cell... 
    
    return cell;
}


#pragma mark - 
#pragma mark UITableViewDelegate Protocol methods 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 64.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedFolder = [self folderForRow:indexPath.row];
    
    [tableView reloadData];
}

@end
