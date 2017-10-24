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
@property (copy, nonatomic) UIImage *image;


@end


@implementation Cat

- (instancetype)initWithULR:(NSURL *)url andDescription:(NSString *)description
{
    self.coordinate = kCLLocationCoordinate2DInvalid;
    return [self initWithULR:url andDescription:description andLocation:kCLLocationCoordinate2DInvalid];
}

- (instancetype)initWithULR:(NSURL *)url andDescription:(NSString *)description andLocation:(CLLocationCoordinate2D)location
{
    self = [super init];
    if (self) {
        _url = url;
        _photoDescription = description;
        _location = location;

    }
    return self;
}


+(instancetype)newCatWithULR:(NSURL *)url andDescription:(NSString *)description
{
    return [[Cat alloc] initWithULR:url andDescription:description];
}

-(void)getCatImage:(void (^)(UIImage *))completionHandler
{
    if (self.image) {
        completionHandler(self.image);
    } else {
        [self downloadImage:^(UIImage *theImage){
            self.image = theImage;
            completionHandler(theImage);
        }];
    }

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

-(void)test{
    self.coordinate = kCLLocationCoordinate2DInvalid;
}

//-(CLLocationCoordinate2D)coordinate{
//    return self.location;
//}

@synthesize title = _title;

-(NSString *)title{
    return self.photoDescription;
}


@end
