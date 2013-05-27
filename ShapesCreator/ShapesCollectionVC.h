//
//  ShapesCollectionVC.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 01.03.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArrangedDataObjectsCollectionVC.h"

#import "Shape.h"


@interface ShapesCollectionVC : ArrangedDataObjectsCollectionVC <ArrangedCollectionViewAndDataObjectHandlingDelegate> {
    
}


- (void)displayShape:(Shape*)shape;
- (void)editShape:(Shape*)shape;
- (void)moveShape:(Shape*)shape;
- (void)shareShape:(Shape*)shape;


@end
