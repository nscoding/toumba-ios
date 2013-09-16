//
//  TMMapPin.m
//  Toumba
//
//  Created by Patrick Chamelo on 9/16/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//

#import "TMMapPin.h"

@implementation TMMapPin

- (id)initWithCoordinates:(CLLocationCoordinate2D)location
                    title:(NSString *)title
                 subTitle:(NSString *)subTitle
{
    if ((self = [super init]))
    {
        self.title = title;
        self.subtitle = subTitle;
        self.coordinate = location;
    }
    
    return self;
}


@end
