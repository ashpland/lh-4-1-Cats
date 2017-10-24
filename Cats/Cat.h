//
//  Cat.h
//  Cats
//
//  Created by Andrew on 2017-10-23.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import MapKit;

@interface Cat : NSObject <MKAnnotation>

@property (copy, nonatomic, readonly) UIImage *image;
@property (assign, nonatomic) NSInteger index;
@property (copy, nonatomic) NSString *photoDescription;
@property (assign, nonatomic) CLLocationCoordinate2D location;

- (instancetype)initWithULR:(NSURL *)url andDescription:(NSString *)description;
- (instancetype)initWithULR:(NSURL *)url andDescription:(NSString *)description andLocation:(CLLocationCoordinate2D)location;


+ (instancetype)newCatWithULR:(NSURL *)url andDescription:(NSString *)description;

- (void)downloadCatImage:(void (^)(Cat *theCat))completionHandler;



@end
