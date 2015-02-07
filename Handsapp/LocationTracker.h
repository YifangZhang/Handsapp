//
//  LocationTracker.h
//  Handsapp
//
//  Created by Yifang Zhang on 1/25/15.
//  Special thanks from Rick and Puru Shukla
//  from: ﻿http://mobileoop.com/background-location-update-programming-for-ios-7﻿
//  Copyright (c) 2015 Tailung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationShareModel.h"
//#import "ShopLocation.h"

@interface LocationTracker : NSObject <CLLocationManagerDelegate>

@property (nonatomic) CLLocationCoordinate2D myLastLocation;
@property (nonatomic) CLLocationAccuracy myLastLocationAccuracy;

@property (strong,nonatomic) LocationShareModel * shareModel;

@property (nonatomic) CLLocationCoordinate2D myLocation;
@property (nonatomic) CLLocationAccuracy myLocationAccuracy;

+ (CLLocationManager *)sharedLocationManager;

- (void)startLocationTracking;
- (void)stopLocationTracking;
- (void)updateLocationToServer;

/* comparison and upload to server functions */
- (NSInteger) compareWithShopLocation;
- (void) uploadIfLocationChanged: (NSInteger)newShopID;
        //TODO: real implementation with test on real server,
        //      Also, send a local notification to let user know location changed

@end
