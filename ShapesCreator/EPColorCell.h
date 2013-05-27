//
//  EPColorCell.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 19.02.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EditablePropertyTableViewCell.h"

#import "ColorComponentView.h"


@interface EPColorCell : EditablePropertyTableViewCell {
    
    UIColor *propertyValueColor;
    
    IBOutlet ColorComponentView *hueValueView;
    IBOutlet ColorComponentView *saturationValueView;
    IBOutlet ColorComponentView *brightnessValueView;
    IBOutlet ColorComponentView *alphaValueView;
}

@property (strong, nonatomic) UIColor *propertyValueColor;

@property (strong, nonatomic) IBOutlet ColorComponentView *hueValueView;
@property (strong, nonatomic) IBOutlet ColorComponentView *saturationValueView;
@property (strong, nonatomic) IBOutlet ColorComponentView *brightnessValueView;
@property (strong, nonatomic) IBOutlet ColorComponentView *alphaValueView;


@end
