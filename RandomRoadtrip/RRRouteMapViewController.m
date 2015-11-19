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
@property (strong, nonatomic) MKPlacemark *origin;
@property (strong, nonatomic) MKPlacemark *destination;

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
    //geocode the from location and handle the returned placemark
    [[[CLGeocoder alloc] init] geocodeAddressString:fromLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //grab the first placemark and set it as the origin placemark
        self.origin = [[MKPlacemark alloc] initWithPlacemark:[placemarks firstObject]];
        //add the origin placemark to the map
        [self.mapView addAnnotation:self.origin];
        
        //check if the destination has also been set
        if (self.destination) {
            //we have the origin and destination; next step is to getAndDisplayTravelTime
            [self getAndDisplayTravelTime];
        }
    }];
    
    //do the same process for the to location
    [[[CLGeocoder alloc] init] geocodeAddressString:toLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        self.destination = [[MKPlacemark alloc] initWithPlacemark:[placemarks firstObject]];
        [self.mapView addAnnotation:self.destination];
        if (self.origin) {
            [self getAndDisplayTravelTime];
        }
    }];
}

- (void)getAndDisplayTravelTime {
    //create request
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource:[[MKMapItem alloc] initWithPlacemark:self.origin]];
    [request setDestination:[[MKMapItem alloc] initWithPlacemark:self.destination]];
    [request setTransportType:MKDirectionsTransportTypeAutomobile];
    
    //send request
    [[[MKDirections alloc] initWithRequest:request] calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        //handle request
        MKRoute *route = [[response routes] firstObject];
        double travelTimeInHours =[route expectedTravelTime] / 60 / 60;
        
        //prepare and show alert with driving time
        NSString *title = [NSString stringWithFormat:@"%@ to %@",self.origin.locality,self.destination.locality];
        NSString *message = [NSString stringWithFormat:@"Driving time is %.0f hours",travelTimeInHours];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }];
}

@end
