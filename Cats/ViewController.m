//
//  ViewController.m
//  Cats
//
//  Created by Andrew on 2017-10-23.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "ViewController.h"
#import "CatManager.h"

@interface ViewController ()

@property (strong, nonatomic) CatManager *catManager;

@end

@implementation ViewController




-(void)viewDidLoad {
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;

    
    self.catManager = [CatManager new];
    
    //Cat *newCat = [self.catManager getCatForIndex:0];

    [self downloadCatData];

}


- (void)downloadCatData {
    NSURL *urlToDownload = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=6ac625bcee7d4d029c39412ab2df4b38&tags=cat"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:urlToDownload
                                                        completionHandler:^(NSURL * _Nullable locationOfDownloadedFile,
                                                                            NSURLResponse * _Nullable response,
                                                                            NSError * _Nullable error) {
                                                            [self processJSON:error locationOfDownloadedFile:locationOfDownloadedFile];
                                                            
                                                        }];
    
    [downloadTask resume];
}

- (void)processJSON:(NSError * _Nullable)error locationOfDownloadedFile:(NSURL * _Nullable)locationOfDownloadedFile {
    if (error) { // 1
        // Handle the error
        NSLog(@"error: %@", error.localizedDescription);
        return;
    }
    
    NSData *downloadedRawData = [NSData dataWithContentsOfURL:locationOfDownloadedFile];
    
    NSError *jsonError = nil;
    NSArray *catDicts = [NSJSONSerialization JSONObjectWithData:downloadedRawData options:0 error:&jsonError];
    
    if (jsonError) { // 3
        // Handle the error
        NSLog(@"jsonError: %@", jsonError.localizedDescription);
        return;
    }
    
    for (NSDictionary *curCatDict in catDicts) {
        [self.catManager addCat:curCatDict];
    }
}



@end
