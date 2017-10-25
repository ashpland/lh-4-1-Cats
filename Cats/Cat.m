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
@property (copy, nonatomic) NSString *idString;

@end


@implementation Cat

@synthesize coordinate = _coordinate;
@synthesize title = _title;


- (instancetype)initWithURL:(NSURL *)url andDescription:(NSString *)description andID:(NSString *)idString
{
    self = [super init];
    if (self) {
        _url = url;
        _photoDescription = description;
        _idString = idString;
        
    }
    return self;
    
}


+(instancetype)newCatWithURL:(NSURL *)url andDescription:(NSString *)description andID:(NSString *)idString
{
    return [[Cat alloc] initWithURL:url andDescription:description andID:idString];
}



-(CLLocationCoordinate2D)coordinate{
    return [self.location coordinate];
}


-(NSString *)title{
    return self.photoDescription;
}

-(void)requestCatImage:(void (^)(Cat *))catImageAvailable
{
    [self downloadURL:self.url withCompletion:^(NSData *rawData){
        self.image = [UIImage imageWithData:rawData];
        catImageAvailable(self);
    }];
}

-(void)requestCatLocation:(void (^)(Cat *))catLocationAvailable {
    NSString *geoURLString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&format=json&nojsoncallback=1&api_key=6ac625bcee7d4d029c39412ab2df4b38&photo_id=%@", self.idString];
    NSURL *urlToDownload = [NSURL URLWithString:geoURLString];
    
    self.location = [self processLocationJSON:urlToDownload];
    catLocationAvailable(self);
}


-(void)downloadURL:(NSURL *)url withCompletion:(void (^)(NSData *rawData))downloadComplete
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDownloadTask *downloadTask =
    [session downloadTaskWithURL:self.url
               completionHandler:^(NSURL * _Nullable downloadFile,
                                   NSURLResponse * _Nullable response,
                                   NSError * _Nullable error)
    {
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        NSData *rawData = [NSData dataWithContentsOfURL:downloadFile];
        
        downloadComplete(rawData);
    }];
    
    [downloadTask resume];
}

- (CLLocation *)processLocationJSON:(NSURL *)geoURL {
    NSData *rawData = [NSData dataWithContentsOfURL: geoURL];

    
    NSError *jsonError = nil;
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:rawData options:NSJSONReadingAllowFragments error:&jsonError];
    
    if (jsonError) {
        NSLog(@"jsonError: %@", jsonError.localizedDescription);
        return nil;
    }
    
    NSDictionary *locationDict = [[parsedJSON objectForKey:@"photo"] objectForKey:@"location"];
    double lat = [(NSString *)[locationDict objectForKey:@"latitude"] doubleValue];
    double lon = [(NSString *)[locationDict objectForKey:@"longitude"] doubleValue];

    return [[CLLocation alloc] initWithLatitude:lat longitude:lon];
}

@end
