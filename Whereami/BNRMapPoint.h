//
//  BNRMapPoint.h
//  Whereami
//
//  Created by Ramon Bartl on 27.12.12.
//  Copyright (c) 2012 Ramon Bartl. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>

@interface BNRMapPoint : NSObject <MKAnnotation>
{
}

// new designated initializer for instances of BNRMapPoint
- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;

// required property from MKAnnotation
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

// optional property from MKAnnotation
@property (nonatomic, copy) NSString *title;

@end