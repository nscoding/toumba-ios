//
//  TMLocationHelper.m
//  Toumba
//
//  Created by Patrick on 4/21/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//

#import "TMLocationHelper.h"
#import "TMAngleCalculator.h"

#import "BlockAlertView.h"


// ------------------------------------------------------------------------------------------


@implementation TMLocationHelper

- (id)init
{
    if ((self = [super init]))
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    return self;
}


- (void)startTracking
{
    [self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingHeading];
}


- (void)stopTracking
{
    [self.locationManager stopUpdatingHeading];
    [self.locationManager stopUpdatingHeading];
}


// ------------------------------------------------------------------------------------------
#pragma mark - Location Manager Delegates
// ------------------------------------------------------------------------------------------
- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading
{
	CGFloat heading = -1.0f * M_PI * newHeading.trueHeading / 180.0f;
    if (self.delegate && [self.delegate respondsToSelector:@selector(headingForCompassDidChange:)])
    {
        [self.delegate headingForCompassDidChange:heading];
    }
    
	CGFloat toumpaHeading =  -1.0f * [TMAngleCalculator
                                      calculateAngleWithLatitude:self.currentLocation.coordinate.latitude
                                      andLongitude:self.currentLocation.coordinate.longitude];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(headingForStadiumDidChange:)])
    {
        [self.delegate headingForStadiumDidChange:heading - toumpaHeading];
    }
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
	NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    
    if (locationAge > 5.0)
        return;
    
	// test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0)
        return;
	
    _currentLocation = newLocation;
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{    
    NSString *errorType;
    NSString *errorMessage;
    
    if (error.code == kCLErrorDenied)
    {
        errorType = @"Access Denied";
        errorMessage = @"Turn on your location services in the settings app "
                       @"to allow \"Toumba\" to determine your location";
    }
    else
    {
        errorType = @"Something went wrong";
        errorMessage = @"There was an error retrieving your location";
    }
    

    [BlockAlertView showInfoAlertWithTitle:errorType
                                   message:errorMessage];
}



@end
