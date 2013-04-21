//
//  TMViewController.m
//  Toumba
//
//  Created by Patrick on 4/21/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//

#import "TMViewController.h"


// ------------------------------------------------------------------------------------------


@interface TMViewController ()

- (void)buildAndConfigure;
- (void)buildAndConfigureScrollView;
- (void)buildAndConfigureMadeWithLove;
- (void)buildAndConfigureCompass;

@end


// ------------------------------------------------------------------------------------------


@implementation TMViewController


// ------------------------------------------------------------------------------------------
#pragma mark - View did load
// ------------------------------------------------------------------------------------------
- (void)viewDidLoad
{
    // view did load
    [super viewDidLoad];
    [self.view setFrame:[[UIScreen mainScreen] applicationFrame]];

    // set the background color
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Pattern"]];

    // configure the views
    [self buildAndConfigure];
    

    self.locationHelper = [[TMLocationHelper alloc] init];
    self.locationHelper.delegate = self;
    [self.locationHelper startTracking];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // reset in tracker
    [self.locationHelper stopTracking];
    [self.locationHelper startTracking];
}


// ------------------------------------------------------------------------------------------
#pragma mark - Build and Configure
// ------------------------------------------------------------------------------------------
- (void)buildAndConfigure
{
    [self buildAndConfigureScrollView];
    [self buildAndConfigureMadeWithLove];
    [self buildAndConfigureCompass];
}


- (void)buildAndConfigureScrollView
{
    // create the scroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    // set the properties
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    
    // set the content size
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width + 1.0f,
                                             self.view.frame.size.height);
        
    // add the scroll view
    [self.view addSubview:self.scrollView];
}


- (void)buildAndConfigureMadeWithLove
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    label.textColor = [UIColor colorWithRed:0.839f green:0.839f blue:0.839f alpha:1.00f];
    label.shadowColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    label.shadowOffset = CGSizeMake(0, 1);
    label.textAlignment = NSTextAlignmentCenter;
    label.text =  @"Made in Berlin for PAOK with Love\n❝Patrick Chamelo❞";
    label.numberOfLines = 0;
    
    [label sizeToFit];
    [label setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [label setCenter:CGPointMake(self.scrollView.contentSize.width + 20, self.scrollView.center.y)];
    [self.scrollView addSubview:label];

    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    [logoView setCenter:CGPointMake((-logoView.frame.size.width / 2) + 5, self.scrollView.center.y)];
    [self.scrollView addSubview:logoView];

}


- (void)buildAndConfigureCompass
{
    self.compassBaseView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compass"]];
    self.compassBaseView.center = self.scrollView.center;
    [self.scrollView addSubview:self.compassBaseView];
    
    self.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    self.arrowView.center = self.scrollView.center;
    [self.scrollView addSubview:self.arrowView];
}


// ------------------------------------------------------------------------------------------
#pragma mark - Location delegates
// ------------------------------------------------------------------------------------------
- (void)headingForCompassDidChange:(CGFloat)headingCompass
{
    if (animatesCompass == NO)
    {
        animatesCompass = YES;
        [UIView animateWithDuration:0.5f animations:^{
            self.compassBaseView.transform = CGAffineTransformMakeRotation(headingCompass);
        }
        completion:^(BOOL finished){
            animatesCompass = NO;
        }];
    }
}


- (void)headingForStadiumDidChange:(CGFloat)headingStadium
{
    if (animatesArrow == NO)
    {
        animatesArrow = YES;
        [UIView animateWithDuration:0.5f animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(headingStadium);
        } completion:^(BOOL finished) {
            animatesArrow = NO;
        }];
    }
}


// ------------------------------------------------------------------------------------------
#pragma mark - Memory Warning
// ------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
