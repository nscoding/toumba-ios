//
//  TMLocationHelper.m
//  Toumba
//
//  Created by Patrick on 4/21/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//

#import "TMLocationHelper.h"
#import "TMAngleCalculator.h"


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


- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
    return YES;
}


- (NSString *)distanceToToumba
{
    CLLocation *lastRetrievedLocation = [_locationManager location];
    NSMutableString *formattedDistance = nil;
    
    if (lastRetrievedLocation)
    {
        static NSNumberFormatter *numberFormatter;
        
        if (numberFormatter == nil)
        {
            numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [numberFormatter setMaximumFractionDigits:2];
            [numberFormatter setMinimumFractionDigits:0];
        }
        
        CLLocation *stadium = [[CLLocation alloc] initWithLatitude:40.613708
                                                         longitude:22.972541];
        
        float distance = [lastRetrievedLocation distanceFromLocation:stadium];
        
        BOOL isMetric = [[[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem] boolValue];

        formattedDistance = [[NSMutableString alloc] init];

        if (isMetric)
        {
            [formattedDistance appendFormat:NSLocalizedString(@"stadium_located_$_kilometers", @""),
             [numberFormatter stringFromNumber:[NSNumber numberWithDouble:(distance / 1000.000f)]]];
        }
        else
        {
            [formattedDistance appendFormat:NSLocalizedString(@"stadium_located_$_miles", @""),
             [numberFormatter stringFromNumber:[NSNumber numberWithDouble:(distance / 1609.344f)]]];
        }
    }
    
    return formattedDistance;
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
        errorType = NSLocalizedString(@"app_access_error_title", @"");
        errorMessage = NSLocalizedString(@"app_access_error_subtitle", @"");
    }
    else
    {
        errorType = NSLocalizedString(@"app_generic_error_title", @"");
        errorMessage = NSLocalizedString(@"app_generic_error_subtitle", @"");
    }
    
    if (showsAlert == NO)
    {
        showsAlert = YES;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorType
                                                            message:errorMessage
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Dismiss", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}


- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    showsAlert = NO;
}

@end
