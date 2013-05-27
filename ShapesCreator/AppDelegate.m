//
//  AppDelegate.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 18.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "AppDelegate.h"


#ifdef DEBUG
void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
}
#endif


@implementation AppDelegate

@synthesize window = _window;
@synthesize splashVC;
@synthesize collectionVC;
@synthesize rep;
@synthesize launchDate;

+ (AppDelegate *)instance {
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (BOOL)isiPad {
    
    static BOOL defined = NO;
    static BOOL isIPad = NO;
    if (!defined) {
        defined = YES;
        isIPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    }
	return isIPad;
}

- (NSString*)repositoryFilePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSString *repositoriesFolder = [libraryDirectory stringByAppendingPathComponent:@"/Repositories/"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:repositoriesFolder]) {
        NSError *error = nil;
        if (![fileManager createDirectoryAtPath:repositoriesFolder withIntermediateDirectories:YES attributes:nil error:&error]) {
            
            NSLog(@"-[AppDelegate repositoryFilePath] - failed to create directory at path '%@' with error: %@", repositoriesFolder, error);
            return nil;
        }
    }
    
    return [repositoriesFolder stringByAppendingPathComponent:@"Repository"];
}

- (void)saveRepository {
    
	if (self.rep && self.launchDate) {
        
		NSMutableData *data = [[NSMutableData alloc] init];
		NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        
		[archiver encodeObject:self.rep forKey:@"Repository"];
        
		[archiver finishEncoding];
		[data writeToFile:[self repositoryFilePath] atomically:YES];
    }
}

- (void)loadRepository {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self repositoryFilePath]]) {
        
		NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self repositoryFilePath]];
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
		self.rep = [unarchiver decodeObjectForKey:@"Repository"];
        
		[unarchiver finishDecoding];
    }
    
    if (!self.rep) {
        
        rep = [[Repository alloc] init];
    }
}

- (void)displaceSplash {
    
	[splashVC.view removeFromSuperview];
    self.splashVC = nil;
    
    /*
    mainShape = [[Shape alloc] initWithSupershape:nil];
    [mainShape populate];
    
    shapeVC = [[ShapeVC alloc] initWithShape:mainShape];
    [self.window addSubview:shapeVC.view];
     */
    
    collectionVC = [[ShapesCollectionVC alloc] init];
    [self.window addSubview:collectionVC.view];
}

- (void)restoreRepository {
    
	@autoreleasepool {
    
        NSDate *startSetupDate = [NSDate date];
        
        [self loadRepository];
        
        NSTimeInterval loadingRepTimeInterval = 0.0 - [startSetupDate timeIntervalSinceNow];
        
        
        const NSTimeInterval minimumStartingTimeInterval = 2.5;
        
        if (loadingRepTimeInterval < minimumStartingTimeInterval) {
            
            [NSThread sleepForTimeInterval:(minimumStartingTimeInterval - loadingRepTimeInterval)];
        }
        
        self.launchDate = [NSDate date];
	}
    
	[self performSelectorOnMainThread:@selector(displaceSplash) withObject:nil waitUntilDone:NO];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#ifdef DEBUG
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
#endif
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    splashVC = [[SplashVC alloc] init];
    [self.window addSubview:splashVC.view];	
    [self.window makeKeyAndVisible];
    
    [NSThread detachNewThreadSelector:@selector(restoreRepository) toTarget:self withObject:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    
    [self saveRepository];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    [self saveRepository];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
    [self saveRepository];
}

@end
