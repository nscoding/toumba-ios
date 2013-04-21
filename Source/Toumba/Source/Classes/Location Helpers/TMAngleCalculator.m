//
//  TMAngleCalculator.m
//  Toumba
//
//  Created by Patrick on 4/21/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//

#import "TMAngleCalculator.h"


// ------------------------------------------------------------------------------------------


@implementation TMAngleCalculator


+ (CGFloat)calculateAngleWithLatitude:(double)lat
                         andLongitude:(double)lon
{
	
	double_t lat1,lon1,lat2,lon2;
	lat1 = lat;
	lon1 = lon;
	lat2 = 40.613708;
	lon2 = 22.972541;
	
	lat1 = lat1 * (M_PI / 180.0f);
	lat2 = lat2 * (M_PI / 180.0f);
	lon1 = lon1 * (M_PI / 180.0f);
	lon2 = lon2 * (M_PI / 180.0f);
	
	double_t deltaLong = lon2 - lon1;
	double_t y  = sin(deltaLong) * cos(lat2);
	double_t x  = cos(lat1) * sin(lat2) -  (sin(lat1) * cos(lat2) * cos(deltaLong));
	double_t bearing = atan2(y, x);
	
	bearing =  bearing * (180.0f / M_PI);
	bearing = (bearing + 360);
	
	CGFloat moduloResult = (float)((int)bearing % (int)360);
	CGFloat heading2 = M_PI * moduloResult / 180.0f;
	
	return heading2;
}


@end
