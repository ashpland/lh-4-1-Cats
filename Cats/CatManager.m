//
//  CatManager.m
//  Cats
//
//  Created by Andrew on 2017-10-23.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "CatManager.h"
@import MapKit;

@interface CatManager ()

@property (strong, nonatomic) NSMutableArray<Cat *> *theCats;

@end

@implementation CatManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.theCats = [NSMutableArray new];
    }
    return self;
}


-(void)addCat:(NSDictionary *)catInfo
{
    NSString *catURLString = [NSString
                              stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",
                              [catInfo objectForKey:@"farm"],
                              [catInfo objectForKey:@"server"],
                              [catInfo objectForKey:@"id"],
                              [catInfo objectForKey:@"secret"]
                              ];
    
    NSURL *catURL = [NSURL URLWithString:catURLString];
    
    
    
    
    Cat *newCat = [Cat newCatWithULR:catURL andDescription:[catInfo objectForKey:@"title"]];
    
    newCat.index = self.theCats.count;
    
    [self.theCats addObject:newCat];
    
    [self addCatLocation:newCat withID:[catInfo objectForKey:@"id"]];
    
}

-(void)addCatLocation:(Cat *)cat withID:(NSString *)idString{
    
    [self downloadLocationDataFor:idString withCompletion:^(CLLocationCoordinate2D coordinates){
        cat.location = coordinates;
    }];
    
}

-(Cat *)getCatForIndex:(NSInteger)index
{
    if (index < self.theCats.count)
        return self.theCats[index];
    else
        return nil;
}

-(NSInteger)numberOfCats
{
    return self.theCats.count;
}



- (void)downloadLocationDataFor:(NSString *)photoID withCompletion:(void (^)(CLLocationCoordinate2D coordinates))completionHandler  {
    NSString *geoURLString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&format=json&nojsoncallback=1&api_key=6ac625bcee7d4d029c39412ab2df4b38&photo_id=%@", photoID];
    
    NSURL *urlToDownload = [NSURL URLWithString:geoURLString];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:urlToDownload
                                                        completionHandler:^(NSURL * _Nullable locationOfDownloadedFile,
                                                                            NSURLResponse * _Nullable response,
                                                                            NSError * _Nullable error) {
                                                             CLLocationCoordinate2D retrievedCoordinates =  [self processLocationJSON:error locationOfDownloadedFile:locationOfDownloadedFile];
                                                            
                                                            completionHandler(retrievedCoordinates);
                                                            
                                                        }];
    
    [downloadTask resume];
}

- (CLLocationCoordinate2D)processLocationJSON:(NSError * _Nullable)error locationOfDownloadedFile:(NSURL * _Nullable)locationOfDownloadedFile {
    if (error) { // 1
        // Handle the error
        NSLog(@"error: %@", error.localizedDescription);
        return kCLLocationCoordinate2DInvalid;
    }
    
    NSData *downloadedRawData = [NSData dataWithContentsOfURL:locationOfDownloadedFile];
    
    NSError *jsonError = nil;
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:downloadedRawData options:0 error:&jsonError];
    
    if (jsonError) { // 3
        // Handle the error
        NSLog(@"jsonError: %@", jsonError.localizedDescription);
        return kCLLocationCoordinate2DInvalid;
    }
    
    NSDictionary *locationDict = [[parsedJSON objectForKey:@"photo"] objectForKey:@"location"];
    double lat = [(NSString *)[locationDict objectForKey:@"latitude"] doubleValue];
    double lon = [(NSString *)[locationDict objectForKey:@"longitude"] doubleValue];

    return CLLocationCoordinate2DMake(lat, lon);
    
    
}



@end
