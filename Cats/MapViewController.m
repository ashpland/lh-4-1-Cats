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
    self.navigationController.navigationBar.prefersLargeTitles = NO;

    
    [self setupMapView];

    self.mapManager.locationManager.delegate = self;
    
    
    [self addTestAnnotations];
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


-(void)addTestAnnotations
{
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc]init];
    myAnnotation.coordinate = CLLocationCoordinate2DMake(49.281838, -123.108151);
    [myAnnotation setTitle:@"LHL"];
    [myAnnotation setSubtitle:@"Where we currently are"];
    [self.mapView addAnnotation: myAnnotation];
    
    [self.mapView addAnnotation:[CatManager getCatForIndex:0]];
    [self.mapView addAnnotation:[CatManager getCatForIndex:1]];
    
    //Maybe wrap the code in a if(cat.location) then get location thing like in the data source method
    
}


@end
