//
//  Cat.m
//  Cats
//
//  Created by Andrew on 2017-10-23.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "Cat.h"

@interface Cat ()

@property (strong, nonatomic) NSURL *url;

@end


@implementation Cat

- (instancetype)initWithULR:(NSURL *)url andDescription:(NSString *)description
{
    self = [super init];
    if (self) {
        _url = url;
        _photoDescription = description;
    }
    return self;
}

+(instancetype)newCatWithULR:(NSURL *)url andDescription:(NSString *)description
{
    return [[Cat alloc] initWithULR:url andDescription:description];
}

-(UIImage *)image{
    return nil;
}

-(void)getCatImage:(void (^)(UIImage *))blockName
{
    UIImage *theimage;
    
    blockName(theimage);
}

@end
