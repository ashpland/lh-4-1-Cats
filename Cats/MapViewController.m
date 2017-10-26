//
//  MapViewController.m
//  Cats
//
//  Created by Andrew on 2017-10-24.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "MapViewController.h"
#import "MapManager.h"
#import "CatManager.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MapManager *mapManager;

@end

@implementation MapViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMapView];

    self.mapManager.locationManager.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated
{
//    [self addCatsGCD];
    [self addCatsNSO];
}


- (void)setupMapView {
    self.mapView.mapType = MKMapTypeStandard;
    [self.mapView setZoomEnabled: true];
    [self.mapView setRotateEnabled:true];
    [self.mapView setScrollEnabled:true];
    [self.mapView showsScale];
    self.mapView.delegate = self;
}


-(MapManager *)mapManager
{
    if (!_mapManager)
        _mapManager = [MapManager sharedMapManager];
    return _mapManager;
}



// the following two methods loop Flickr api calls because there doesn't seem to be a way to request a batch of photos including location image, or to query their geo api with more than one photo id :(

-(void)addCatsGCD
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);

    dispatch_async(queue, ^{
    for (Cat *currentCat in [CatManager allTheCats]){
            if (currentCat.location) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mapView addAnnotation:currentCat];
                });
            } else {
                [currentCat requestCatLocation:^(Cat *theCat){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.mapView addAnnotation:theCat];
                    });

                }];
            }
    } });
}

-(void)addCatsNSO
{
    
    NSOperationQueue *myQueue = [NSOperationQueue new];
    myQueue.maxConcurrentOperationCount = 50;
    
    for (Cat *currentCat in [CatManager allTheCats]){

        NSBlockOperation *catLocationOperation = [NSBlockOperation blockOperationWithBlock:^{
            if (currentCat.location) {
                NSBlockOperation *addAnnotation = [NSBlockOperation blockOperationWithBlock:^{
                    [self.mapView addAnnotation:currentCat];
                }];
                addAnnotation.queuePriority = NSOperationQueuePriorityVeryLow;
                [[NSOperationQueue mainQueue] addOperation:addAnnotation];
            }
            
            else {
                [currentCat requestCatLocation:^(Cat *theCat){
                    [currentCat requestCatLocation:^(Cat *theCat){
                        NSBlockOperation *addAnnotation = [NSBlockOperation blockOperationWithBlock:^{
                            [self.mapView addAnnotation:currentCat];
                        }];
                        addAnnotation.queuePriority = NSOperationQueuePriorityVeryLow;
                        [[NSOperationQueue mainQueue] addOperation:addAnnotation];
                    }];
                }];
            }
        }];
        
        [myQueue addOperation:catLocationOperation];
    }
}



@end
