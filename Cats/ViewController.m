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
    
    self.catManager = [CatManager new];
    
    NSDictionary *testDict = @{
                               @"id" : @"37183031884",
                               @"secret" : @"b1a05cfe1d",
                               @"server" : @"4451",
                               @"farm" : @5,
                               @"title" : @"And bringing their fiendish cat along"
                               };
    
    
    [self.catManager addCat:testDict];
    
    Cat *newCat = [self.catManager getCatForIndex:0];
    
    
    
    
    
    
//
//NSURL *urlToDownload = [NSURL URLWithString:@"http://imgur.com/CoQ8aNl.png"]; // 1
//
//NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
//NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
//
//NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:urlToDownload
//                                                    completionHandler:^(NSURL * _Nullable locationOfDownloadedFile,
//                                                                        NSURLResponse * _Nullable response,
//                                                                        NSError * _Nullable error) {
//                                                        if (error) { // 1
//                                                            // Handle the error
//                                                            NSLog(@"error: %@", error.localizedDescription);
//                                                            return;
//                                                        }
//
//                                                        NSData *downloadedRawData = [NSData dataWithContentsOfURL:locationOfDownloadedFile];
//                                                        UIImage *imageFromDownloadedRawData = [UIImage imageWithData:downloadedRawData]; // 2
//
//                                                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                                                            // This will run on the main queue
//
//                                                            self.theImageView.image = imageFromDownloadedRawData; // 4
//                                                        }];
//
//                                                    }]; // 4
//
//[downloadTask resume]; // 5

}


@end
