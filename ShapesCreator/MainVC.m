//
//  MainVC.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 01.03.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "MainVC.h"

#import "AppDelegate.h"


@implementation MainVC

- (NSString*)nibIdentifier {
    
    if ([AppDelegate isiPad]) {
        
        return @"MainView-iPad";
    }
    
    return @"MainView";
}

- (id)init {
    
    self = [super initWithNibName:self.nibIdentifier bundle:nil];
    
    if (self) {
        
        // Custom initialization 
        
        [self inAnimationWithStatusBarHiding:NO];
    }
    
    return self;
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
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    // Return YES for supported orientations
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

@end
