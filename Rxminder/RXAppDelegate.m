//
//  RXAppDelegate.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXAppDelegate.h"

#import <AppCoreKit/AppCoreKit.h>
#import <ResourceManager/ResourceManager.h>
#import "RKHamburgerTableViewController.h"
#import "RXTaskListTableViewController.h"
#import "RXApplicationState.h"
#import "RXLocalPatientSource.h"
#import "ZUUIRevealController.h"

@implementation RXAppDelegate

- (id)init{
   self = [super init];
    
    [CKMappingContext loadContentOfFileNamed:@"Rxminder"];
    
#ifdef DEBUG
    [CKConfiguration initWithContentOfFileNames:@"AppCoreKit" type:CKConfigurationTypeDebug];
#else
    [CKConfiguration initWithContentOfFileNames:@"AppCoreKit" type:CKConfigurationTypeRelease];
#endif
    
    
#ifdef __has_feature(objc_arc)
    [[CKConfiguration sharedInstance]setUsingARC:YES];
#endif
    
    
#if TARGET_IPHONE_SIMULATOR
    
    NSString* projectPath = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"SRC_ROOT"];
if(! projectPath){
	NSAssert(NO,@"Define SRC_ROOT in your application .plist with value '$SRCROOT/$PROJECT/'");
}

    RMBundleResourceRepository* localRepository = [[RMBundleResourceRepository alloc]initWithPath:projectPath];
    localRepository.pullingTimeInterval = 1;

    RMResourceManager* resourceManager = [[RMResourceManager alloc]initWithRepositories:@[localRepository]];
    
    [RMResourceManager setSharedManager:resourceManager];
#else 
#endif 
    
   return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    RKHamburgerTableViewController *revealController = [RKHamburgerTableViewController controller];
    RXTaskListTableViewController *taskListController = [RXTaskListTableViewController controller];
    
    UINavigationController *revealContainer = [[UINavigationController alloc] initWithRootViewController:revealController];
    revealContainer.navigationBarHidden = YES;
    UINavigationController *mainContainer = [[UINavigationController alloc] initWithRootViewController:taskListController];
    mainContainer.navigationBar.translucent = NO;
    
    ZUUIRevealController* hamburger = [[ZUUIRevealController alloc] initWithFrontViewController:mainContainer rearViewController:revealContainer];
    hamburger.rearViewRevealWidth = 210;
    hamburger.delegate = taskListController;
    taskListController.revealController = hamburger;
    
    taskListController.navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:hamburger action:@selector(revealGesture:)];
    [taskListController.view addGestureRecognizer:taskListController.navigationBarPanGestureRecognizer];
    taskListController.navigationBarPanGestureRecognizer.delegate = taskListController;
    
    [[RXApplicationState sharedInstance] setPatients:[CKArrayCollection collectionWithFeedSource:[RXLocalPatientSource feedSource]]];
    
    self.window = [UIWindow  viewWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = hamburger;
    [self.window makeKeyAndVisible];

    [RMResourceManager handleApplication:application didFinishLaunchingWithOptions:launchOptions];

    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//	[RMResourceManager handleApplication:application openURL:url];
//
//    return YES;
//}

@end
