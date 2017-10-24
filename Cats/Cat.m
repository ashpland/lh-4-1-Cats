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
@property (copy, nonatomic, readwrite) UIImage *image;

@end


@implementation Cat

- (instancetype)initWithURL:(NSURL *)url andDescription:(NSString *)description
{
    return [self initWithURL:url andDescription:description andLocation:kCLLocationCoordinate2DInvalid];
}

- (instancetype)initWithURL:(NSURL *)url andDescription:(NSString *)description andLocation:(CLLocationCoordinate2D)location
{
    self = [super init];
    if (self) {
        _url = url;
        _photoDescription = description;
        _location = location;

    }
    return self;
}


+(instancetype)newCatWithURL:(NSURL *)url andDescription:(NSString *)description
{
    return [[Cat alloc] initWithURL:url andDescription:description];
}

-(void)requestCatImage:(void (^)(Cat *))completionHandler
{
    [self downloadImage:^(UIImage *theImage){
        self.image = theImage;
        completionHandler(self);
    }];
}

-(void)downloadImage:(void (^)(UIImage *theImage))completionHandler
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:self.url
                                                        completionHandler:^(NSURL * _Nullable locationOfDownloadedFile,
                                                                            NSURLResponse * _Nullable response,
                                                                            NSError * _Nullable error) {
                                                            if (error) {
                                                                NSLog(@"error: %@", error.localizedDescription);
                                                                return;
                                                            }
                                                            
                                                            NSData *downloadedRawData = [NSData dataWithContentsOfURL:locationOfDownloadedFile];
                                                            UIImage *downloadedImage = [UIImage imageWithData:downloadedRawData];
                                                            
                                                            completionHandler(downloadedImage);
                                                            
                                                        }];
    [downloadTask resume];
}

@synthesize coordinate = _coordinate;

-(CLLocationCoordinate2D)coordinate{
    return self.location;
}

@synthesize title = _title;

-(NSString *)title{
    return self.photoDescription;
}


@end
