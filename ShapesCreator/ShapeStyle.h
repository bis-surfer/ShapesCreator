//
//  ShapeStyle.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 14.02.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EditableObject.h"
#import "EPTVCellDataSource.h"


@interface ShapeStyle : NSObject <EditableObject, NSCoding> {
    
    UIColor *fillColor;
    UIColor *outlineColor;
    CGFloat lineWidth;
}

@property (strong, nonatomic) UIColor *fillColor;
@property (strong, nonatomic) UIColor *outlineColor;
@property (nonatomic) CGFloat lineWidth;


- (CGColorRef)fillCGColor;
- (CGColorRef)outlineCGColor;


@end
