//
//  TMViewController.h
//  Toumba
//
//  Created by Patrick on 4/21/13.
//  Copyright (c) 2013 Patrick Chamelo - nscoding. All rights reserved.
//

#import "TMLocationHelper.h"


@interface TMViewController : UIViewController <UIScrollViewDelegate, TMLocationHelperDelegate>
{
    BOOL animatesCompass;
    BOOL animatesArrow;
}
@property (nonatomic, strong) TMLocationHelper *locationHelper;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *footerLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UIImageView *compassBaseView;
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UIImageView *arrowToStadium;
@property (nonatomic, strong) UITextView *historyTextView;

@end
