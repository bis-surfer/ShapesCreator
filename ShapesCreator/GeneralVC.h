//
//  GeneralVC.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 02.03.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;


@interface GeneralVC : UIViewController {
    
    AppDelegate *ad;
    CGFloat animationDuration;
    BOOL isRemovingFromSuperview;
    
    GeneralVC *upperVC;
    
    BOOL isStatusBarHidden;
}

@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) BOOL isRemovingFromSuperview;
@property (strong, nonatomic) GeneralVC *upperVC;


- (BOOL)canAddUpperView;

- (void)inAnimationWithStatusBarHiding:(BOOL)hideStatusBar;
- (void)inAnimation;
- (void)outAnimation;

- (void)registerDoneHandler:(SEL)selector forNotificationNamed:(NSString*)notificationName sentByUpperVC:(GeneralVC*)theUpperVC;
- (void)handleDoneNotification:(NSNotification *)notification;


@end
