//
//  TMMapPin.h
//  Toumba
//
//  Created by Patrick Chamelo on 9/16/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface TMMapPin : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


- (id)initWithCoordinates:(CLLocationCoordinate2D)location
                    title:(NSString *)title
                 subTitle:(NSString *)subTitle;

@end
