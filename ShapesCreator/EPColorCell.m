//
//  EPColorCell.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 19.02.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EPColorCell.h"


@implementation EPColorCell

@synthesize propertyValueColor;
@synthesize hueValueView;
@synthesize saturationValueView;
@synthesize brightnessValueView;
@synthesize alphaValueView;

- (void)setupWithPropertyName:(NSString *)aPropertyName andValueObject:(id)aPropertyValueObject {
    
    [super setupWithPropertyName:aPropertyName andValueObject:aPropertyValueObject];
    
    [self setupWithPropertyValue:aPropertyValueObject];
}

- (void)setupWithPropertyValue:(UIColor *)aPropertyValueColor {
    
    self.propertyValueColor = aPropertyValueColor;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
}

@end
