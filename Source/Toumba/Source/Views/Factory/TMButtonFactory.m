//
//  TMButtonFactory.m
//  Toumba
//
//  Created by Patrick on 5/8/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//

#import "TMButtonFactory.h"


// ------------------------------------------------------------------------------------------


@implementation TMButtonFactory


+ (UIButton *)greyButtonForTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];    
    UIImage *buttonImage = [[UIImage imageNamed:@"GRGreyButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"GRGreyButtonHighlight"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor colorWithWhite:1.0 alpha:0.9] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:1.0 alpha:0.9] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];

    button.titleLabel.shadowOffset = CGSizeMake(0, 1);
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;

    return button;
}


+ (UIButton *)blackButtonForTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"GRBlackButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"GRBlackButtonHighlight"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor colorWithWhite:0.0 alpha:0.9] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:0.0 alpha:0.9] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return button;
}


@end
