//
//  ViewController.m
//  Cats
//
//  Created by Andrew on 2017-10-23.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "ViewController.h"
#import "CatManager.h"
#import "CatCollectionDataSource.h"
#import "PhotoLayout.h"

@interface ViewController ()

@property (strong, nonatomic) CatManager *catManager;
@property (strong, nonatomic) UIImage *testImage;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) CatCollectionDataSource *catCollectionDataSource;

@end

@implementation ViewController




-(void)viewDidLoad {
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;

    
    self.catManager = [CatManager new];
    
    [self downloadCatData];

    self.catCollectionDataSource = [CatCollectionDataSource new];
    self.catCollectionDataSource.catManager = self.catManager;
    
    self.collectionView.dataSource = self.catCollectionDataSource;
    self.collectionView.delegate = self;
    
    self.collectionView.collectionViewLayout = [[PhotoLayout alloc] initWithPhotosPerRow:2];

    
    
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
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:downloadedRawData options:0 error:&jsonError];
    
    if (jsonError) { // 3
        // Handle the error
        NSLog(@"jsonError: %@", jsonError.localizedDescription);
        return;
    }
    
    NSArray *catDicts = [[parsedJSON objectForKey:@"photos"] objectForKey:@"photo"];
    
    
    for (NSDictionary *curCatDict in catDicts) {
        [self.catManager addCat:curCatDict];
    }
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.collectionView reloadData];
    }];

    
}



@end
