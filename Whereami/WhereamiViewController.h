//
//  WhereamiViewController.h
//  Whereami
//
//  Created by Ramon Bartl on 16.12.12.
//  Copyright (c) 2012 Ramon Bartl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereamiViewController : UIViewController <CLLocationManagerDelegate,
                                                      MKMapViewDelegate,
                                                      UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
}

- (void)findLocation;
- (void)foundLocation:(CLLocation *)loc;

@end