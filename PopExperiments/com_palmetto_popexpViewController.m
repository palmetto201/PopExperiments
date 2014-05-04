//
//  com_palmetto_popexpViewController.m
//  PopExperiments
//
//  Created by Ali Ahmed on 5/3/14.
//  Copyright (c) 2014 palmetto201. All rights reserved.
//

#import "com_palmetto_popexpViewController.h"
#import "POP/POP.h"

#define VisiblePosition CGPointMake(160.0f,120.0f)
#define VisibleReadyPosition CGPointMake(160.0f,120.0f)
#define HiddenPosition CGPointMake(80.0f,60.0f)

@interface com_palmetto_popexpViewController ()

@property (nonatomic)BOOL isMenuOpen;

@end


@implementation com_palmetto_popexpViewController

- (void)viewDidLoad
{
    _isMenuOpen = NO;
    [super viewDidLoad];
    [self setupAddWebUIView];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //_viewWeb.layer.transform = CATransform3DMakeScale(1, 1, 1);
    _viewWeb.layer.position = HiddenPosition;
    _viewWeb.layer.opacity = 4.0f;
    _viewWeb.layer.cornerRadius = 4.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hidePopup
{
    _isMenuOpen = NO;
    //POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    //opacityAnimation.fromValue = @(1);
    //opacityAnimation.toValue = @(0);
    //[_viewWeb.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:VisiblePosition];
    positionAnimation.toValue = [NSValue valueWithCGPoint:HiddenPosition];
    [_viewWeb.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    scaleAnimation.fromValue  = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleAnimation.toValue  = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
    [_viewWeb.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)showPopup
{
    _isMenuOpen = YES;
    
    //POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    //opacityAnimation.fromValue = @(0);
    //opacityAnimation.toValue = @(1);
    //opacityAnimation.beginTime = CACurrentMediaTime() + 0.1;
    //[_viewWeb.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:VisibleReadyPosition];
    positionAnimation.toValue = [NSValue valueWithCGPoint:VisiblePosition];
    [_viewWeb.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.fromValue  = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5f)];
    scaleAnimation.toValue  = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];//@(0.0f);
    scaleAnimation.springBounciness = 40.0f;
    scaleAnimation.springSpeed = 60.0f;
    [_viewWeb.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)togglePopup
{
    if (!_isMenuOpen)
    {
        [self showPopup];
    }
    else
    {
        [self hidePopup];
    }
}

#pragma mark - Setup Add Button

- (void)setupAddWebUIView
{
    
    NSString *fullURL = @"http://www.google.com";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_viewWeb loadRequest:requestObj];
    [self startTimer];
    [self showPopup];
}

- (void) startTimer {
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

- (void) tick:(NSTimer *) timer {
    
    [self togglePopup];
}

@end
