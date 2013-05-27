//
//  EPTVCellDataSource.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 22.02.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EPTVCellDataSource.h"


@implementation EPTVCellDataSource

@synthesize cellIdentifier;
@synthesize cellHeight;
@synthesize propertyName;
@synthesize propertyValueObject;

- (id)initWithCellIdentifier:(NSString*)aCellIdentifier cellHeight:(CGFloat)aCellHeight propertyName:(NSString*)aPropertyName andPropertyValueObject:(id)aPropertyValueObject {
	
    self = [super init];
    
    if (self) {
        
        self.cellIdentifier      = aCellIdentifier;
        self.cellHeight          = aCellHeight;
        self.propertyName        = aPropertyName;
        self.propertyValueObject = aPropertyValueObject;
    }
    
    return self;
}

@end
