//
//  EPTVCellDataSource.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 22.02.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EPTVCellDataSource : NSObject {
    
    NSString *cellIdentifier;
    CGFloat cellHeight;
    NSString *propertyName;
    id propertyValueObject;
}

@property (strong, nonatomic) NSString *cellIdentifier;
@property (nonatomic) CGFloat cellHeight;
@property (strong, nonatomic) NSString *propertyName;
@property (strong, nonatomic) id propertyValueObject;


- (id)initWithCellIdentifier:(NSString*)aCellIdentifier cellHeight:(CGFloat)aCellHeight propertyName:(NSString*)aPropertyName andPropertyValueObject:(id)aPropertyValueObject;


@end
