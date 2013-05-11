//
//  TMViewController.m
//  Toumba
//
//  Created by Patrick on 4/21/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//

#import "TMViewController.h"
#import "TMButtonFactory.h"


// ------------------------------------------------------------------------------------------


@interface TMViewController ()

- (void)buildAndConfigure;
- (void)buildAndConfigureScrollView;

- (void)buildAndConfigureVisitPAOKFC;
- (void)buildAndConfigureVisitPAOKMegastore;
- (void)buildAndConfigureCallPAOK;

- (void)buildAndConfigureMadeWithLove;
- (void)buildAndConfigureDistance;
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
    [self buildAndConfigureLogo];
    [self buildAndConfigureVisitPAOKFC];
    [self buildAndConfigureVisitPAOKMegastore];
    
    [self buildAndConfigureMadeWithLove];
    [self buildAndConfigureCompass];
    [self buildAndConfigureDistance];
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
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2,
                                             self.view.frame.size.height);
    
    self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
        
    // add the scroll view
    [self.view addSubview:self.scrollView];
}


- (void)buildAndConfigureLogo
{
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    [logoView setCenter:CGPointMake((self.view.frame.size.width / 2), self.scrollView.center.y - 50)];
    [self.scrollView addSubview:logoView];
}


- (void)buildAndConfigureVisitPAOKFC
{
    UIButton *visitPAOKFC = [TMButtonFactory greyButtonForTitle:NSLocalizedString(@"button_visit_paok_fc", @"")];
    visitPAOKFC.frame = CGRectMake(0, 0, self.view.frame.size.width - 60, 40);
    
    [visitPAOKFC addTarget:self
                    action:@selector(visitPAOKFC)
          forControlEvents:UIControlEventTouchUpInside];
    
    [visitPAOKFC setCenter:CGPointMake(self.view.frame.size.width / 2, self.scrollView.center.y + 120)];
    [self.scrollView addSubview:visitPAOKFC];
}


- (void)buildAndConfigureVisitPAOKMegastore
{
    UIButton *visitMegastore = [TMButtonFactory greyButtonForTitle:NSLocalizedString(@"button_visit_paok_magastore", @"")];
    visitMegastore.frame = CGRectMake(0, 0, self.view.frame.size.width - 60, 40);

    [visitMegastore addTarget:self
                    action:@selector(visitPAOKMegastore)
          forControlEvents:UIControlEventTouchUpInside];

    [visitMegastore setCenter:CGPointMake(self.view.frame.size.width / 2, self.scrollView.center.y + 170)];
    [self.scrollView addSubview:visitMegastore];
}


- (void)buildAndConfigureCallPAOK
{

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
    label.text =  @"Made in Berlin for PAOK with Love\n❝Patrick - Vasileia❞";
    label.numberOfLines = 0;
    
    [label sizeToFit];
    [label setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [label setCenter:CGPointMake(self.scrollView.contentSize.width + 20, self.scrollView.center.y)];
    [self.scrollView addSubview:label];
}


- (void)buildAndConfigureCompass
{
    self.compassBaseView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compass"]];
    self.compassBaseView.center = self.scrollView.center;
    [self.compassBaseView setCenter:CGPointMake(self.scrollView.frame.size.width * 1.5,
                                                self.scrollView.center.y - 20)];

    [self.scrollView addSubview:self.compassBaseView];
    
    self.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.arrowView setCenter:self.compassBaseView.center];
    [self.scrollView addSubview:self.arrowView];
}


- (void)buildAndConfigureDistance
{
    self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width - 40, 70)];
    self.distanceLabel.backgroundColor = [UIColor clearColor];
    self.distanceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    self.distanceLabel.textColor = [UIColor colorWithRed:0.839f green:0.839f blue:0.839f alpha:1.00f];
    self.distanceLabel.shadowColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    self.distanceLabel.shadowOffset = CGSizeMake(0, 1);
    self.distanceLabel.textAlignment = NSTextAlignmentCenter;
    self.distanceLabel.text =  @"";
    self.distanceLabel.numberOfLines = 0;
    
    [self.distanceLabel setCenter:CGPointMake(self.scrollView.frame.size.width * 1.5,
                                              self.compassBaseView.frame.origin.y +
                                              self.compassBaseView.frame.size.height + 45)];
    [self.scrollView addSubview:self.distanceLabel];
}


// ------------------------------------------------------------------------------------------
#pragma mark - Location delegates
// ------------------------------------------------------------------------------------------
- (void)headingForCompassDidChange:(CGFloat)headingCompass
{
    NSString *distance = [self.locationHelper distanceToToumba];
    self.distanceLabel.text = distance ?: @"";
    
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
#pragma mark - Actions
// ------------------------------------------------------------------------------------------
- (void)visitPAOKFC
{
    NSURL *url = [NSURL URLWithString:@"http://www.paokfc.gr"];
    [[UIApplication sharedApplication] openURL:url];
}


- (void)visitPAOKMegastore
{
    NSURL *url = [NSURL URLWithString:@"http://www.paok-megastore.gr"];
    [[UIApplication sharedApplication] openURL:url];
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
