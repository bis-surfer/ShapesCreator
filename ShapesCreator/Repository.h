//
//  Repository.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 26.02.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ShapesCollection.h"


@interface Repository : NSObject <NSCoding> {
    
    ShapesCollection *shapesCollection;
}

@property (strong, nonatomic) ShapesCollection *shapesCollection;


@end
