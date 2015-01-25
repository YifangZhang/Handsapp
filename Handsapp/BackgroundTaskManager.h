//
//  BackgroundTaskManager.h
//  Handsapp
//
//  Created by Yifang Zhang on 1/25/15.
//  Copyright (c) 2015 Tailung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BackgroundTaskManager : NSObject

+(instancetype)sharedBackgroundTaskManager;
-(UIBackgroundTaskIdentifier)beginNewBackgroundTask;
-(void)endAllBackgroundTasks;

@end
