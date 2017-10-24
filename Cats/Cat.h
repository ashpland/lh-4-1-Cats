//
//  Cat.h
//  Cats
//
//  Created by Andrew on 2017-10-23.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Cat : NSObject

@property (copy, nonatomic) NSString *photoDescription;
@property (copy, nonatomic) UIImage *image;

- (instancetype)initWithULR:(NSURL *)url andDescription:(NSString *)description;

+ (instancetype)newCatWithULR:(NSURL *)url andDescription:(NSString *)description;

- (void)getCatImage:(void (^)(UIImage *theImage))blockName;



@end
