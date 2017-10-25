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
@property (copy, nonatomic) CLLocation *location;

- (instancetype)initWithURL:(NSURL *)url andDescription:(NSString *)description andID:(NSString *)idString;


+(instancetype)newCatWithURL:(NSURL *)url andDescription:(NSString *)description andID:(NSString *)idString;

- (void)requestCatImage:(void (^)(Cat *theCat))completionHandler;
- (void)requestCatLocation:(void (^)(Cat *theCat))completionHandler;



@end
