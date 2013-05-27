//
//  ShapeVC.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 18.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GeneralVC.h"

#import "Shape.h"
#import "ShapeView.h"


@interface ShapeVC : GeneralVC {
    
    Shape *mainShape;
    
    IBOutlet UIButton *backBtn;
}

@property (strong, nonatomic) Shape *mainShape;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;


- (NSString*)nibIdentifier;

- (id)initWithShape:(Shape*)theShape;

- (IBAction)done:(id)sender;


@end
