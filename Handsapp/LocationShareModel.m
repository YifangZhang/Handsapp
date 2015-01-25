//
//  LocationShareModel.m
//  Handsapp
//
//  Created by Yifang Zhang on 1/25/15.
//  Special thanks from Rick and Puru Shukla
//  from: ﻿http://mobileoop.com/background-location-update-programming-for-ios-7﻿
//  Copyright (c) 2015 Tailung. All rights reserved.
//

#import "LocationShareModel.h"

@implementation LocationShareModel

//Class method to make sure the share model is synch across the app
+ (id)sharedModel
{
    static id sharedMyModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyModel = [[self alloc] init];
    });
    return sharedMyModel;
}


@end
