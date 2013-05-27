//
//  EditableObject.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 19.02.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EPTVCellDataSource.h"


@protocol EditableObject <NSObject>

@required
- (NSArray*)editableObjectTableViewData;

@end
