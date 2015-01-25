//
//  LocationShareModel.h
//  Handsapp
//
//  Created by Yifang Zhang on 1/25/15.
//  Special thanks from Rick and Puru Shukla
//  from: ﻿http://mobileoop.com/background-location-update-programming-for-ios-7﻿
//  Copyright (c) 2015 Tailung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BackgroundTaskManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationShareModel : NSObject

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSTimer * delay10Seconds;
@property (nonatomic) BackgroundTaskManager * bgTask;
@property (nonatomic) NSMutableArray *myLocationArray;

+(id)sharedModel;


@end
