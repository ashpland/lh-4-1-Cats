//
//  MapManager.m
//  Cats
//
//  Created by Andrew on 2017-10-24.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "MapManager.h"

@interface MapManager ()

@end

@implementation MapManager

+ (instancetype)sharedMapManager {
    static MapManager *mapManagerPrime = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapManagerPrime = [self new];
    });
    return mapManagerPrime;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [CLLocationManager new];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10; //have to move 10m before location manager checks again
        [_locationManager requestAlwaysAuthorization];

    }
    return self;
}


@end
