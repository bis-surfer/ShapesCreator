//
//  AppDelegate.h
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 18.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SplashVC.h"
#import "ShapesCollectionVC.h"
#import "ShapeVC.h"
#import "Repository.h"


#ifdef DEBUG
void uncaughtExceptionHandler(NSException *exception);
#endif


@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    SplashVC *splashVC;
    Repository *rep;
    NSDate *launchDate;
    
    Shape *mainShape;
    ShapeVC *shapeVC;
    ShapesCollectionVC *collectionVC;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SplashVC *splashVC;
@property (strong, nonatomic) ShapesCollectionVC *collectionVC;
@property (strong, nonatomic) Repository *rep;
@property (strong, nonatomic) NSDate *launchDate;


+ (AppDelegate *)instance;
+ (BOOL)isiPad;


@end
