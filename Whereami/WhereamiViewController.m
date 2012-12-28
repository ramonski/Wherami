//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Ramon Bartl on 16.12.12.
//  Copyright (c) 2012 Ramon Bartl. All rights reserved.
//

#import "WhereamiViewController.h"
#import "BNRMapPoint.h"


@implementation WhereamiViewController


#pragma mark View Livecycle

- (void)findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

- (void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D coord = [loc coordinate];
    
    BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord
                                                        title:[locationTitleField text]];
    [worldView addAnnotation:mp];
    
    // Zoom the region to this location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [worldView setRegion:region animated:YES];
    
    // Reset the UI
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    }
    return self;
}


- (void)viewDidLoad
{
    [worldView setShowsUserLocation:YES];
}


- (void)dealloc
{
    // Tell the location manager to stop sending us messages
    [locationManager setDelegate:nil];
}


#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", newLocation);
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    
    if (t < -180) {
        return;
    }
    
    [self foundLocation:newLocation];
}


- (void)locationManager:(CLLocationManager *)manager
    didFailWithError:(NSError *)error
{
    NSLog(@"Could not find Location: %@", error);
}


#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView
    didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [worldView setRegion:region animated:YES];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self findLocation];
    
    [textField resignFirstResponder];
    return YES;
}

@end