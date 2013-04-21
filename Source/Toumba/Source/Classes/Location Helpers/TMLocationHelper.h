//
//  TMLocationHelper.h
//  Toumba
//
//  Created by Patrick on 4/21/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>


@protocol TMLocationHelperDelegate <NSObject>

- (void)headingForCompassDidChange:(CGFloat)headingCompass;
- (void)headingForStadiumDidChange:(CGFloat)headingStadium;

@end


@interface TMLocationHelper : NSObject <CLLocationManagerDelegate>

@property (strong) CLLocationManager *locationManager;
@property (strong, readonly) CLLocation *currentLocation;
@property (weak) id<TMLocationHelperDelegate> delegate;

- (void)startTracking;
- (void)stopTracking;

@end
