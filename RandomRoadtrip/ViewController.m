//
//  ViewController.m
//  RandomRoadtrip
//
//  Created by David Olesch on 11/16/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "ViewController.h"
#import "RRRouteMapViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *fromField;
@property (weak, nonatomic) IBOutlet UITextField *toField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchedRandomLocation:(id)sender {
    //create a list of cities
    NSArray *cities = @[@"New York, NY",@"Los Angeles, CA",@"Chicago, IL",@"Philadelphia, PA",@"Phoenix, AZ",@"San Diego, CA",@"San Jose, CA",@"Jacksonville, FL",@"Indianapolis, IN",@"San Francisco, CA"];
    
    //choose a random integer less than the count of cities
    int randomIndex = arc4random_uniform((int)[cities count]);
    //choose the city from the cities list at the random integer index
    NSString *city = [cities objectAtIndex:randomIndex];
    
    //set the chosen city as the text of the view's To field
    [self.toField setText:city];
}

//this method runs when transitioning from the search view to the map view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //the transition segue has a reference to the map view in destinationViewController
    RRRouteMapViewController *routeMapViewController = [segue destinationViewController];
    
    //we send the from location and to location to the map view while transtioning to the map view
    [routeMapViewController mapFromLocation:self.fromField.text toLocation:self.toField.text];
}

@end
