//
//  ArrangedDataObjectsCollection.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 01.03.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Folder.h"
#import "Trash.h"


@interface ArrangedDataObjectsCollection : NSObject <NSCoding> {
    
    Folder *rootFolder;
    Folder *currentFolder;
    Trash *trash;
    Folder *builtInFolder;
}

@property (strong, nonatomic) Folder *rootFolder;
@property (strong, nonatomic) Folder *currentFolder;
@property (strong, nonatomic) Trash *trash;
@property (strong, nonatomic) Folder *builtInFolder;


- (BOOL)areCurrentlyInRootFolder;
- (BOOL)areCurrentlyInTrash;
- (BOOL)areCurrentlyInBuiltInFolder;
- (Folder*)ascendToSuperfolder;
- (Folder*)descentToSubfolder:(Folder*)subfolder;
- (NSString*)truncatedSuperfolderTitleForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

- (NSInteger)displayedBuiltInFolderCount;
- (NSInteger)displayedSubfoldersCount;
- (NSInteger)displayedDataObjectsCount;
- (NSInteger)displayedTrashCount;

- (Folder*)displayedSubfolderAtIndex:(NSInteger)index;
- (id)displayedDataObjectAtIndex:(NSInteger)index;


@end
