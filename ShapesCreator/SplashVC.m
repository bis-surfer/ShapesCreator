//
//  SplashVC.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 27.02.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "SplashVC.h"
#import "AppDelegate.h"


@implementation SplashVC

- (NSString*)nibIdentifier {
    
    if ([AppDelegate isiPad]) {
        
        return @"SplashView-iPad";
    }
    
    return @"SplashView";
}

- (id)init {
    
    self = [super initWithNibName:self.nibIdentifier bundle:nil];
    
    if (self) {
        
        // Custom initialization 
    }
    
    return self;
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    // Return YES for supported orientations
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    if ([AppDelegate isiPad]) {
        
        return YES;
    }
    
    return YES;
}

@end
