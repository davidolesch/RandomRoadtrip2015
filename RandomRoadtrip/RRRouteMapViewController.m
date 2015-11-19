//
//  RRRouteMapViewController.m
//  RandomRoadtrip
//
//  Created by David Olesch on 11/16/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "RRRouteMapViewController.h"
#import <MapKit/MapKit.h>

@interface RRRouteMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation RRRouteMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)mapFromLocation:(NSString *)fromLocation toLocation:(NSString *)toLocation {
}

@end
