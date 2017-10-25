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
    [self addCats];
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

-(void)addCats
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
  
    for (Cat *currentCat in [CatManager allTheCats]){
        dispatch_async(queue, ^{
            if (currentCat.location) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mapView addAnnotation:currentCat];
                });
            } else {
                [currentCat requestCatLocation:^(Cat *theCat){
                    [self.mapView addAnnotation:theCat];
                }];
            }
        });
    }
}
        



@end
