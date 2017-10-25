//
//  MapManager.h
//  Cats
//
//  Created by Andrew on 2017-10-24.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface MapManager : NSObject

@property (strong, nonatomic) CLLocationManager *locationManager;

+ (instancetype)sharedMapManager;

@end
