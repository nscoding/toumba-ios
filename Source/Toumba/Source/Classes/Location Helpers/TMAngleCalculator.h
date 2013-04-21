//
//  TMAngleCalculator.h
//  Toumba
//
//  Created by Patrick on 4/21/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//

@interface TMAngleCalculator : NSObject

+ (CGFloat)calculateAngleWithLatitude:(double)lat
                         andLongitude:(double)lon;

@end
