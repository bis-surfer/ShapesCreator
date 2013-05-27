//
//  Folder.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 26.02.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Shape.h"


@interface Folder : NSObject <NSCoding> {
    
    NSString *title;
    
    Folder *superfolder;
    
    NSMutableArray *subfolders;
    NSMutableArray *data_objects;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) Folder *superfolder;
@property (nonatomic, retain) NSMutableArray *subfolders;
@property (nonatomic, retain) NSMutableArray *data_objects;


- (id)initWithTitle:(NSString*)aTitle andSuperfolder:(Folder*)aSuperfolder;

- (void)addSubfolderTitled:(NSString*)sTitle;
- (void)addSubfolder:(Folder*)subfolder;
- (void)addDataObject:(id<DataObject>)dataObject;

- (BOOL)hasContents;
- (NSString*)describeContentsUsingDataObjectType:(NSString*)dataObjectType;
- (NSUInteger)subfoldersCount;
- (NSUInteger)dataObjectsCount;
- (NSUInteger)itemsCount;
- (Folder*)subfolderAtIndex:(NSInteger)index;
- (id)dataObjectAtIndex:(NSInteger)index;
- (id)itemAtIndex:(NSInteger)index;

- (NSArray*)allDataObjects;
- (NSUInteger)allDataObjectsCount;
- (NSUInteger)allFoldersCount;
- (NSUInteger)allItemsCount;
- (BOOL)hasDataObjectsInside;
- (NSUInteger)idleFoldersCount;
- (Folder*)folderAtIndex:(NSUInteger)index;
- (NSInteger)indexOfFolder:(Folder*)folder;
- (id)itemInTreeStructureAtIndex:(NSUInteger)index includingIdleFolders:(BOOL)includeIdleFolders;
- (NSInteger)indexInTreeStructureOfItem:(id)item includingIdleFolders:(BOOL)includeIdleFolders;

- (NSUInteger)levelInTree;
- (NSUInteger)levelOfNestingForDataObject:(id)dataObject;
- (BOOL)isContainedAtFolder:(id)someFolder;

- (void)removeSubfolder:(Folder*)subfolder;
- (void)removeDataObject:(id)dataObject inSubfoldersAlso:(BOOL)removeInSubfoldersAlso;

- (void)clear;


@end
