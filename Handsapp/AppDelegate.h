//
//  AppDelegate.h
//  Handsapp
//
//  Created by Yifang Zhang on 1/12/15.
//  Copyright (c) 2015 Tailung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationTracker.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property LocationTracker * locationTracker;
@property (nonatomic) NSTimer* locationUpdateTimer;


@end

