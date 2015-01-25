//
//  AppDelegate.m
//  Handsapp
//
//  Created by Yifang Zhang on 1/12/15.
//  Copyright (c) 2015 Tailung. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        //ios 8
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        //lower than ios 8
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    //Code for Finding Location
    UIAlertView * alert;
    
    //We have to make sure that the Background App Refresh is enable for the Location updates to work in the background.
    if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied){
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The app doesn't work without the Background App Refresh enabled. To turn it on, go to Settings > General > Background App Refresh"
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted){
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The functions of this app are limited because the Background App Refresh is disable."
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    } else{
        
        self.locationTracker = [[LocationTracker alloc]init];
        [self.locationTracker startLocationTracking];
        
        //Send the best location to server every 60 seconds
        //You may adjust the time interval depends on the need of your app.
        NSTimeInterval time = 60.0;
        self.locationUpdateTimer =
        [NSTimer scheduledTimerWithTimeInterval:time
                                         target:self
                                       selector:@selector(updateLocation)
                                       userInfo:nil
                                        repeats:YES];
    }
    
    //end of Code for Finding Location

    return YES;
}

-(void)updateLocation {
    NSLog(@"updateLocation");
    
    [self.locationTracker updateLocationToServer];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTheTable" object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTheTable" object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark push notification
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);

    NSString *device = [deviceToken description];
    device = [device stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    device = [device stringByReplacingOccurrencesOfString:@" " withString:@""];
    // insert into memory
    [[NSUserDefaults standardUserDefaults] setObject:device forKey:@"DeviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

#pragma mark push notification for ios 8
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    UIApplicationState state = [application applicationState];

    if (state == UIApplicationStateActive) {
        NSString *cancelTitle = @"Close";
        NSString *showTitle = @"Hide";
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"News for HandsApp"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:cancelTitle
                                                  otherButtonTitles:showTitle, nil];
        [alertView show];
        //storing the message into tableData
        /*NSMutableArray * tableData = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tableData"] mutableCopy];
        if(!tableData ){
            tableData = [[NSMutableArray alloc] initWithCapacity:20];
        }
        [tableData addObject:message];
        NSLog(@"message: %@", message);
        NSLog(@"%lu", (unsigned long)(tableData.count));
        [[NSUserDefaults standardUserDefaults] setObject: tableData forKey: @"tableData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTheTable" object:nil];*/
        
    } else {
        //Do stuff that you would do if the application was not active
        /*NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        NSMutableArray * tableData = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tableData"] mutableCopy];
        if(!tableData ){
            tableData = [[NSMutableArray alloc] initWithCapacity:20];
        }
        [tableData addObject:message];
        NSLog(@"message: %@", message);
        NSLog(@"%lu", (unsigned long)(tableData.count));
        [[NSUserDefaults standardUserDefaults] setObject: tableData forKey: @"tableData"];
        [[NSUserDefaults standardUserDefaults] synchronize];*/
        
    }
    
    
    
}

@end
