//
//  WallDesignSketch.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 05.10.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//
//

#import "WallDesignSketch.h"

#import "Rectangle.h"
#import "Axes.h"


@implementation WallDesignSketch

- (id)init {
    
    return [self initWithSupershape:nil];
}

- (id)initWithSupershape:(Shape*)theSuperShape {
	
    self = [super initWithSupershape:theSuperShape];
    
    if (self) {
        
        self.title = @"Wall design sketch";
        self.isBuiltIn = NO;
        self.iconName = @"shape_icon_InteriorDesign.png";
        
        [self populate];
    }
    
    return self;
}

- (void)populate {
    
    double fi = 0.5*(sqrt(5.0) + 1.0);
    double fi2 = fi*fi;
    double fi_i = 1.0/fi;
    double fi2_i = 1.0/fi2;
    
    double ratio_h1  = fi2/(1.0 + fi2);
    double ratio_h1_ = 1.0/(1.0 + fi2);
    
    double ratio_w1 = 1.0/(2.0 + fi_i + 2.0*fi);
    
    Rectangle *wall = [[Rectangle alloc] initWithSupershape:self x0:0.0 y0:0.0 xs:3.75 ys:3.04];
    [subShapes addObject:wall];
    
    [self applyTheSelfStyleForSubShapes];
    self.style.fillColor = [UIColor colorWithRed:0.90 green:0.75 blue:1.0 alpha:0.5];
    
    double win1_x = 1.0*ratio_w1*wall.xs;
    double win1_y = ratio_h1_*wall.ys;
    double win1_w = fi*ratio_w1*wall.xs;
    double win1_h = ratio_h1*wall.ys;
    
    NSLog(@"window1: {%f, %f, %f, %f}; S = %f", win1_x, win1_y, win1_w, win1_h, win1_w*win1_h);
    
    Rectangle *window1 = [[Rectangle alloc] initWithSupershape:self x0:(win1_x + 0.5*win1_w - 0.5*wall.xs) y0:(win1_y + 0.5*win1_h - 0.5*wall.ys) xs:win1_w ys:win1_h];
    window1.style.fillColor = [UIColor lightGrayColor];
    [subShapes addObject:window1];
    
    double win2_x = (1.0 + fi + fi_i)*ratio_w1*wall.xs;
    double win2_y = 0.0;
    double win2_w = win1_w;
    double win2_h = ratio_h1*wall.ys;
    
    NSLog(@"window2: {%f, %f, %f, %f}; S = %f", win2_x, win2_y, win2_w, win2_h, win2_w*win2_h);
    
    Rectangle *window2 = [[Rectangle alloc] initWithSupershape:self x0:(win2_x + 0.5*win2_w - 0.5*wall.xs) y0:(win2_y + 0.5*win2_h - 0.5*wall.ys) xs:win2_w ys:win2_h];
    window2.style.fillColor = [UIColor lightGrayColor];
    [subShapes addObject:window2];
    
    NSLog(@"x_marking: %f, %f, %f, %f", 1.0*ratio_w1*wall.xs, (1.0 + fi)*ratio_w1*wall.xs, (1.0 + fi + fi_i)*ratio_w1*wall.xs, (1.0 + 2.0*fi + fi_i)*ratio_w1*wall.xs);
    NSLog(@"y_marking: %f, %f", ratio_h1_*wall.ys, ratio_h1*wall.ys);
    
    double win3_w = 0.0;
    
    BOOL sizeIsFixed = NO;
    
    if (sizeIsFixed) {
        
        win3_w = 1.59;
    }
    else {
        
        double ratio_w2 = 1.0/(2.0 + fi2_i);
        win3_w = ratio_w2*wall.xs;
    }
    
    double win3_h = win3_w;
    double win3_x = wall.xs - win3_w - fi2_i*win3_w;
    double win3_y = wall.ys - win3_h - fi_i*fi2_i*win3_h;
    
    NSLog(@"window3: {%f, %f, %f, %f}; S = %f", win3_x, win3_y, win3_w, win3_h, win3_w*win3_h);
    
    Rectangle *window3 = [[Rectangle alloc] initWithSupershape:self x0:(win3_x + 0.5*win3_w - 0.5*wall.xs) y0:(win3_y + 0.5*win3_h - 0.5*wall.ys) xs:win3_w ys:win3_h];
    window3.style.fillColor = [UIColor colorWithRed:0.75 green:0.95 blue:0.80 alpha:0.30];
    [subShapes addObject:window3];
    
    NSLog(@"x_marking: %f, %f", fi2_i*win3_w, fi2_i*win3_w + win3_w);
    NSLog(@"y_marking: %f, %f", win3_y, win3_y + win3_h);
    
    /*
    Axes *axes = [[Axes alloc] initWithSupershape:self x_axis_length:12.0 y_axis_length:12.0 scaleInterval:1.0];
    [subShapes addObject:axes];
     */
}

@end
