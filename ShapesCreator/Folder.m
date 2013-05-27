//
//  Folder.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 26.02.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "Folder.h"


@implementation Folder 

@synthesize title;
@synthesize superfolder;
@synthesize subfolders;
@synthesize data_objects;

- (id)init {
    
    return [self initWithTitle:@"Shapes Collection" andSuperfolder:nil];
}

- (id)initWithTitle:(NSString*)aTitle andSuperfolder:(Folder*)aSuperfolder {
    
    self = [super init];
    
    if (self) {
        
        self.title = aTitle;
        self.superfolder = aSuperfolder;
        
        self.subfolders   = [NSMutableArray array];
        self.data_objects = [NSMutableArray array];
    }
    
    return self;
}

- (void)addSubfolderTitled:(NSString*)sTitle {
    
    Folder *subfolder = [[Folder alloc] initWithTitle:sTitle andSuperfolder:self];
    [subfolders addObject:subfolder];
}

- (void)addSubfolder:(Folder*)subfolder {
    
    subfolder.superfolder = self;
    [subfolders addObject:subfolder];
}

- (void)addDataObject:(id<DataObject>)dataObject {
    
    [data_objects addObject:dataObject];
}

- (BOOL)hasContents {
    
    if ([subfolders count] > 0 || [data_objects count] > 0) {
        
        return YES;
    }
    
    return NO;
}

- (NSString*)describeContentsUsingDataObjectType:(NSString*)dataObjectType {
    
    NSString *description = @"";
    NSUInteger numberOfSubfolders  = [subfolders   count];
    NSUInteger numberOfDataObjects = [data_objects count];
    if (numberOfSubfolders > 0 || numberOfDataObjects > 0) {
        if (numberOfSubfolders > 0) {
            description = [NSString stringWithFormat:@"%u folder", numberOfSubfolders];
            if (numberOfSubfolders > 1) {
                description = [description stringByAppendingString:@"s"];
            }
            if (numberOfDataObjects > 0) {
                description = [description stringByAppendingString:@"; "];
            }
        }
        if (numberOfDataObjects > 0) {
            description = [description stringByAppendingFormat:@"%u %@", numberOfDataObjects, dataObjectType];
            if (numberOfDataObjects > 1) {
                description = [description stringByAppendingString:@"s"];
            }
        }
    }
    return description;
}

- (NSUInteger)subfoldersCount {
    
    return [subfolders count];
}

- (NSUInteger)dataObjectsCount {
    
    return [data_objects count];
}

- (NSUInteger)itemsCount {
    
    return ([subfolders count] + [data_objects count]);
}

- (Folder*)subfolderAtIndex:(NSInteger)index {
    
    if (index < 0) return nil;
    
    return [subfolders objectAtIndex:index];
}

- (id)dataObjectAtIndex:(NSInteger)index {
    
    if (index < 0) return nil;
    
    return [data_objects objectAtIndex:index];
}

- (id)itemAtIndex:(NSInteger)index {
    
    if (index < 0) return nil;
    
    if (index < [subfolders count]) {
        
        return [subfolders objectAtIndex:index];
    }
    
    return [data_objects objectAtIndex:(index - [subfolders count])];
}

- (NSArray*)allDataObjects {
    
    NSMutableArray *all_data_objects = [NSMutableArray arrayWithArray:data_objects];
    
    for (Folder *subfolder in subfolders) {
        
        [all_data_objects addObjectsFromArray:[subfolder allDataObjects]];
    }
    
    return [NSArray arrayWithArray:all_data_objects];
}

- (NSUInteger)allDataObjectsCount {
    
    NSUInteger allDataObjects_count = [data_objects count];
    
    for (Folder *subfolder in subfolders) {
        
        allDataObjects_count += [subfolder allDataObjectsCount];
    }
    
    return allDataObjects_count;
}

- (NSUInteger)allFoldersCount {
    
    NSUInteger allFolders_count = 1;   // self 
    
    for (Folder *subfolder in subfolders) {
        
        allFolders_count += [subfolder allFoldersCount];
    }
    
    return allFolders_count;
}

- (NSUInteger)allItemsCount {
    
    NSUInteger allItems_count = 1;   // self 
    
    allItems_count += [data_objects count];
    
    for (Folder *subfolder in subfolders) {
        
        allItems_count += [subfolder allItemsCount];
    }
    
    return allItems_count;
}

- (BOOL)hasDataObjectsInside {
    
    if ([data_objects count] > 0) {
        
        return YES;
    }
    
    for (Folder *subfolder in subfolders) {
        
        if ([subfolder hasDataObjectsInside]) {
            
            return YES;
        }
    }
    
    return NO;
}

- (NSUInteger)idleFoldersCount {
    
    NSUInteger idleFolders_count = 0;
    
    for (Folder *subfolder in subfolders) {
        
        idleFolders_count += [subfolder idleFoldersCount];
    }
    
    if ([self hasDataObjectsInside]) {
        
        return idleFolders_count;
    }
    
    return 1 + idleFolders_count;
}

- (Folder*)folderAtIndex:(NSUInteger)index {
    
    if (index == 0) {
        
        return self;
    }
    
    index --;
    
    for (Folder *subfolder in subfolders) {
        
        if (index < [subfolder allFoldersCount]) {
            
            return [subfolder folderAtIndex:index];
        }
        else {
            
            index -= [subfolder allFoldersCount];
        }
    }
    
    return nil;
}

- (NSInteger)indexOfFolder:(Folder*)folder {
    
    for (NSUInteger index = 0; index < [self allFoldersCount]; index++) {
        
        if ([folder isEqual:[self folderAtIndex:index]]) {
            
            return index;
        }
    }
    
    return NSNotFound;
}

- (id)itemInTreeStructureAtIndex:(NSUInteger)index includingIdleFolders:(BOOL)includeIdleFolders {
    
    if (index == 0) {
        
        return self;
    }
    index --;
    
    if (index < [data_objects count]) {
        
        return [data_objects objectAtIndex:index];
    }
    index -= [data_objects count];
    
    for (Folder *subfolder in subfolders) {
        
        if (includeIdleFolders || [subfolder hasDataObjectsInside]) {
            
            if (index < [subfolder allItemsCount] - [subfolder idleFoldersCount]) {
                
                return [subfolder itemInTreeStructureAtIndex:index includingIdleFolders:includeIdleFolders];
            }
            else {
                
                index -= [subfolder allItemsCount];
            }
        }
    }
    
    return nil;
}

- (NSInteger)indexInTreeStructureOfItem:(id)item includingIdleFolders:(BOOL)includeIdleFolders {
    
    for (NSUInteger index = 0; index < [self allItemsCount]; index++) {
        
        if ([item isEqual:[self itemInTreeStructureAtIndex:index includingIdleFolders:includeIdleFolders]]) {
            
            return index;
        }
    }
    
    return NSNotFound;
}

- (NSUInteger)levelInTree {
    
    if (superfolder) {
        
        return 1 + [superfolder levelInTree];
    }
    
    return 0;
}

- (NSUInteger)levelOfNestingForDataObject:(id)dataObject {
    
    if ([data_objects containsObject:dataObject]) {
        
        return 1;
    }
    else {
        
        for (Folder *subfolder in subfolders) {
            
            NSUInteger levelOfNestingInSubfolder = [subfolder levelOfNestingForDataObject:dataObject];
            
            if (levelOfNestingInSubfolder != NSNotFound) {
                
                return 1 + levelOfNestingInSubfolder;
            }
        }
    }
    
    return NSNotFound;
}

- (BOOL)isContainedAtFolder:(id)someFolder {
    
    Folder *containingFolder = self.superfolder;
    
    while (containingFolder) {
        
        if ([someFolder isEqual:containingFolder]) {
            
            return YES;
        }
        
        containingFolder = containingFolder.superfolder;
    }
    
    return NO;
}

- (void)removeSubfolder:(Folder*)subfolder {
    
    [subfolders removeObject:subfolder];
}

- (void)removeDataObject:(id)dataObject inSubfoldersAlso:(BOOL)removeInSubfoldersAlso {
    
    [data_objects removeObject:dataObject];
    
    if (!removeInSubfoldersAlso) {
        
        return;
    }
    
    for (Folder *subfolder in subfolders) {
        
        [subfolder removeDataObject:dataObject inSubfoldersAlso:removeInSubfoldersAlso];
    }
}

- (void)clear {
    
    for (id dataObject in [self allDataObjects]) {
        
        [dataObject freeDataObject];
    }
    
    [self.subfolders removeAllObjects];
    [self.data_objects removeAllObjects];
}

#pragma mark - NSCoding Protocol methods 

// Returns an object initialized from data in a given unarchiver (required) 
// Parameters: decoder - an unarchiver object. 
// Return Value: self, initialized using the data in decoder. 
- (id)initWithCoder:(NSCoder *)decoder {
	
    self = [super init];
    
    if (self) {
        
        self.title = [decoder decodeObjectForKey:@"title"];
        
        self.superfolder = nil;
        
        self.subfolders = [decoder decodeObjectForKey:@"subfolders"];
        for (Folder *subfolder in subfolders) {
            subfolder.superfolder = self;
        }
        
        self.data_objects = [decoder decodeObjectForKey:@"data_objects"];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required) 
// Parameters: encoder - an archiver object. 
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:title forKey:@"title"];
    [encoder encodeObject:subfolders forKey:@"subfolders"];
    [encoder encodeObject:data_objects forKey:@"data_objects"];
}

@end
