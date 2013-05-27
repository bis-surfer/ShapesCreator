//
//  ArrangedDataObjectsCollection.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 01.03.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "ArrangedDataObjectsCollection.h"

#import "AppDelegate.h"


@implementation ArrangedDataObjectsCollection

@synthesize rootFolder, currentFolder;
@synthesize trash;
@synthesize builtInFolder;

- (id)init {
	
    self = [super init];
    
    if (self) {
        
        rootFolder = [[Folder alloc] init];
        self.currentFolder = rootFolder;
        trash = [[Trash alloc] initWithTitle:@"Trash" andSuperfolder:rootFolder];
        builtInFolder = [[Folder alloc] initWithTitle:@"built-in Data Objects" andSuperfolder:rootFolder];
    }
    
    return self;
}

- (BOOL)areCurrentlyInRootFolder {
    
    if ([currentFolder isEqual:rootFolder]) {
        
        return YES;
    }
    
    return NO;
}

- (BOOL)areCurrentlyInTrash {
    
    if (trash && [currentFolder isEqual:trash]) {
        
        return YES;
    }
    
    return NO;
}

- (BOOL)areCurrentlyInBuiltInFolder {
    
    if (builtInFolder && [currentFolder isEqual:builtInFolder]) {
        
        return YES;
    }
    
    return NO;
}

- (Folder*)ascendToSuperfolder {
    
    self.currentFolder = currentFolder.superfolder;
    
    return currentFolder;
}

- (Folder*)descentToSubfolder:(Folder*)subfolder {
    
    self.currentFolder = subfolder;
    
    return currentFolder;
}

- (NSString*)truncatedSuperfolderTitleForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    NSString *truncatedTitle = currentFolder.superfolder.title;
    
    NSUInteger maxTitleLengthMultiplier = 1;
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        maxTitleLengthMultiplier = 2;
    }
    
    NSUInteger maxTitleLength = 10;
    if ([AppDelegate isiPad]) {
        maxTitleLength = 20;
    }
    maxTitleLength *= maxTitleLengthMultiplier;
    
    if (truncatedTitle.length > maxTitleLength) {
        truncatedTitle = [truncatedTitle substringToIndex:(maxTitleLength - 4)];
        truncatedTitle = [truncatedTitle stringByAppendingString:@"..."];
    }
    
    return truncatedTitle;
}

- (NSInteger)displayedBuiltInFolderCount {
    
    if (builtInFolder && [self areCurrentlyInRootFolder]) {
        
        return 1;
    }
    
    return 0;
}

- (NSInteger)displayedSubfoldersCount {
    
    return [currentFolder subfoldersCount];
}

- (NSInteger)displayedDataObjectsCount {
    
    return [currentFolder dataObjectsCount];
}

- (NSInteger)displayedTrashCount {
    
    if (trash && [self areCurrentlyInRootFolder]) {
        
        return 1;
    }
    
    return 0;
}

- (Folder*)displayedSubfolderAtIndex:(NSInteger)index {
    
    if (index < 0) return nil;
    if (index >= currentFolder.subfoldersCount) return nil;
    return [currentFolder subfolderAtIndex:index];
}

- (id)displayedDataObjectAtIndex:(NSInteger)index {
    
    if (index < 0) return nil;
    if (index >= currentFolder.dataObjectsCount) return nil;
    return [currentFolder dataObjectAtIndex:index];
}

#pragma mark - NSCoding Protocol methods 

// Returns an object initialized from data in a given unarchiver (required) 
// Parameters: decoder - an unarchiver object. 
// Return Value: self, initialized using the data in decoder. 
- (id)initWithCoder:(NSCoder *)decoder {
	
    self = [super init];
    
    if (self) {
        
        self.rootFolder = [decoder decodeObjectForKey:@"rootFolder"];
        if (!rootFolder) {
            rootFolder = [[Folder alloc] init];
        }
        self.currentFolder = rootFolder;
        
        self.trash = [decoder decodeObjectForKey:@"trash"];
        if (trash) {
            trash.superfolder = rootFolder;
        }
        else {
            trash = [[Trash alloc] initWithTitle:@"Trash" andSuperfolder:rootFolder];
        }
        
        builtInFolder = [[Folder alloc] initWithTitle:@"built-in Data Objects" andSuperfolder:rootFolder];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required) 
// Parameters: encoder - an archiver object. 
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:rootFolder forKey:@"rootFolder"];
    [encoder encodeObject:trash forKey:@"trash"];
}

@end
