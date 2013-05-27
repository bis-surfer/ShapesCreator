//
//  FoldersTreeVC.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 02.03.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GeneralVC.h"

#import "ArrangedDataObjectsCollection.h"
#import "Folder.h"


@interface FoldersTreeVC : GeneralVC <UITableViewDataSource, UITableViewDelegate> {
    
    ArrangedDataObjectsCollection *collection;
    Folder *selectedFolder;
    
    id itemToMove;
    NSInteger indexOfFolderToMove;
    NSInteger countToOmit;
    
    IBOutlet UITableView *foldersStructureTableView;
    IBOutlet UITableViewCell *theCell;
    IBOutlet UIBarButtonItem *doneBtn;
}

@property (strong, nonatomic) ArrangedDataObjectsCollection *collection;
@property (strong, nonatomic) Folder *selectedFolder;
@property (strong, nonatomic) id itemToMove;
@property (strong, nonatomic) IBOutlet UITableView *foldersStructureTableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *theCell;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBtn;

- (NSString*)nibIdentifier;
- (NSString*)cellIdentifier;

- (id)initWithDataObjectsCollection:(ArrangedDataObjectsCollection*)theDataObjectsCollection andItemToMove:(id)theItemToMove;

- (IBAction)done:(id)sender;


@end
