//
//  ShapeVC.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 18.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "ShapeVC.h"

#import "AppDelegate.h"


@implementation ShapeVC

@synthesize mainShape;
@synthesize backBtn;

- (NSString*)nibIdentifier {
    
    if ([AppDelegate isiPad]) {
        
        return @"ShapeView-iPad";
    }
    
    return @"ShapeView";
}

- (id)initWithShape:(Shape*)theShape {
    
    self = [super initWithNibName:self.nibIdentifier bundle:nil];
    
    if (self) {
        
        self.mainShape = theShape;
        
        [self inAnimationWithStatusBarHiding:YES];
    }
    
    return self;
}

- (IBAction)done:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShapeVC_Done_Notification" object:self];
}

- (void)didReceiveMemoryWarning {
    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    ShapeView *shapeView = (ShapeView*)self.view;
    
    shapeView.mainShape = self.mainShape;
    [shapeView setupUnitAndScreenCenter];
    
    [shapeView addDoubleTapGR];
    [shapeView addTwoTouchesTapGR];
    
    [shapeView setNeedsDisplay];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    ShapeView *shapeView = (ShapeView*)self.view;
    shapeView.mainShape_ShapeCsToScreenCsTransform = nil;
    [shapeView setNeedsDisplay];
    
    // Return YES for supported orientations
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

/*
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    ShapeView *shapeView = (ShapeView*)self.view;
    [shapeView setNeedsDisplay];
}
 */

@end
