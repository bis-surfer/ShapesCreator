//
//  GeneralVC.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 02.03.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "GeneralVC.h"

#import "AppDelegate.h"


@implementation GeneralVC

@synthesize animationDuration;
@synthesize isRemovingFromSuperview;
@synthesize upperVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        
        ad = [AppDelegate instance];
        self.animationDuration = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];
        self.isRemovingFromSuperview = NO;
        self.upperVC = nil;
        isStatusBarHidden = NO;
    }
    
    return self;
}

- (BOOL)canAddUpperView {
    
    if (self.isRemovingFromSuperview) return NO;
    if (self.upperVC) return NO;
    
    return YES;
}

- (CGFloat)tx {
    
    return self.view.superview.bounds.size.width;
}

- (CGFloat)ty {
    
    return 0;
}

- (void)inAnimationWithStatusBarHiding:(BOOL)hideStatusBar {
    
    [ad.window addSubview:self.view];
    
    if (hideStatusBar) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        isStatusBarHidden = YES;
        
        self.view.frame = self.view.superview.bounds;
    }
    else {
        
        isStatusBarHidden = NO;
        
        CGRect svBounds = self.view.superview.bounds;
        
        switch (self.interfaceOrientation) {
            case UIInterfaceOrientationPortrait:
                self.view.frame = CGRectMake(svBounds.origin.x, svBounds.origin.y + 20, svBounds.size.width, svBounds.size.height - 20);
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                self.view.frame = CGRectMake(svBounds.origin.x, svBounds.origin.y, svBounds.size.width, svBounds.size.height - 20);
                break;
            case UIInterfaceOrientationLandscapeLeft:
                self.view.frame = CGRectMake(svBounds.origin.x + 20, svBounds.origin.y, svBounds.size.width - 20, svBounds.size.height);
                break;
            case UIInterfaceOrientationLandscapeRight:
                self.view.frame = CGRectMake(svBounds.origin.x, svBounds.origin.y, svBounds.size.width - 20, svBounds.size.height);
                break;
            default:
                self.view.frame = CGRectMake(svBounds.origin.x, svBounds.origin.y + 20, svBounds.size.width, svBounds.size.height - 20);
                break;
        }
    }
    
    self.view.alpha = 0.0;
    // self.view.transform = CGAffineTransformMakeTranslation([self tx], [self ty]);
    
    [UIView animateWithDuration:self.animationDuration 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveEaseIn 
                     animations:^ {
                         
                         self.view.alpha = 1.0;
                         // self.view.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         
                         // nothing to do here 
                     }
     ];
}

- (void)inAnimation {
    
    [self inAnimationWithStatusBarHiding:isStatusBarHidden];
}

- (void)outAnimation {
    
    if (isStatusBarHidden) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
    
    self.view.alpha = 1.0;
    // self.view.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:self.animationDuration 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveEaseOut 
                     animations:^ {
                         
                         self.view.alpha = 0.0;
                         // self.view.transform = CGAffineTransformMakeTranslation([self tx], [self ty]);
                     }
                     completion:^(BOOL finished) {
                         
                         [self.view removeFromSuperview];
                     }
     ];
}

- (void)registerDoneHandler:(SEL)selector forNotificationNamed:(NSString *)notificationName sentByUpperVC:(GeneralVC*)theUpperVC {
    
    [self outAnimation];
    
    self.upperVC = theUpperVC;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:notificationName object:upperVC];
}

- (void)handleDoneNotification:(NSNotification *)notification {
    
    if (!self.upperVC) return;
    if (upperVC.upperVC) return;
    if (notification && self.upperVC != notification.object) return;
    
	[upperVC outAnimation];
    [NSObject cancelPreviousPerformRequestsWithTarget:upperVC];
    [[NSNotificationCenter defaultCenter] removeObserver:upperVC];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:upperVC];
    self.upperVC = nil;
    
    [self inAnimation];
}

@end
