//
//  DataObject.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 19.02.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DataObject <NSObject>

@required
- (NSString*)dataObjectType;
- (NSString*)dataObjectDescription;
- (void)freeDataObject;

@end
