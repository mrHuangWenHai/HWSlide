//
//  HWSideMenuViewController.m
//  HWSideMenu
//
//  Created by 黄文海 on 2018/1/19.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWSideMenuViewController.h"

@interface HWSideMenuViewController ()

@property(nonatomic, strong)UIViewController* contentViewController;
@property(nonatomic, strong)UIViewController* leftMenuViewController;
@property(nonatomic, strong)UIView* contentViewContainer;
@property(nonatomic, strong)UIView* menuViewContainer;
@property(nonatomic, strong)UIView* backgroundImageView;
@property(nonatomic, strong)UIScreenEdgePanGestureRecognizer* edgePan;
@property(nonatomic, strong)UIPanGestureRecognizer* pan;
@property(nonatomic, assign)BOOL leftMenuVisible;

@end

@implementation HWSideMenuViewController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit
{
    _contentViewContainer = [[UIView alloc] init];
    _menuViewContainer = [[UIView alloc] init];
    _backgroundImageView = [[UIView alloc] init];
    _animationTime = 0.5;
    _leftMenuVisible = NO;
}

- (instancetype)initWithContentViewController:(UIViewController*)contentViewController
                       leftMenuViewController:(UIViewController*)leftMenuViewController
{
    self = [self init];
    
    if (self) {
        _contentViewController = contentViewController;
        _leftMenuViewController = leftMenuViewController;
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    _edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenEdgePanGesture:)];
    _edgePan.edges = UIRectEdgeLeft;
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(screenPanGesture:)];
    _pan.enabled = NO;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTap:)];
    [self.contentViewContainer addGestureRecognizer:tap];
    [self.contentViewContainer addGestureRecognizer:self.edgePan];
    [self.contentViewContainer addGestureRecognizer:self.pan];
}

- (void)screenTap:(UITapGestureRecognizer*)tap
{
    if (!self.leftMenuVisible) return;
    [self hideLeftMenuViewController];
    self.pan.enabled = NO;
    self.edgePan.enabled = true;
 
}

- (void)screenPanGesture:(UIPanGestureRecognizer*)pan
{
    static CGPoint lastPoint = {0,0};
    CGPoint point = [pan translationInView:pan.view];
    CGPoint origin = self.contentViewContainer.frame.origin;
    if (origin.x == 0) {
        return;
    }
    
    CGAffineTransform transform = self.contentViewContainer.transform;
    transform.tx += (point.x - lastPoint.x);
    self.contentViewContainer.transform = transform;
    if (pan.state == UIGestureRecognizerStateEnded) {
        lastPoint = CGPointMake(0, 0);
        point.x = self.contentViewContainer.frame.origin.x;
        [self handlePanWithPoint:point];
    }
    else
    {
        lastPoint = point;
    }

}

- (void)screenEdgePanGesture:(UIPanGestureRecognizer*)pan
{
    CGPoint point = [pan translationInView:pan.view];
    CGFloat width = CGRectGetWidth(self.view.bounds);

    if (point.x < width/6*5) {
        self.contentViewContainer.transform = CGAffineTransformMakeTranslation(point.x,0);
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self handlePanWithPoint:point];
    }
}

- (void)handlePanWithPoint:(CGPoint)point
{
    CGAffineTransform transform;
    BOOL leftMenuViewChange = false;
    CGFloat animationTimeLong = 0;
    CGFloat width = CGRectGetWidth(self.view.bounds);

    if (point.x > width / 2 - 20) {
        
        animationTimeLong = (width/6*5 - point.x) / width/6*5 * self.animationTime;
        transform = CGAffineTransformMakeTranslation(width/6*5,0);
        
        if (!self.leftMenuVisible) {
            
            [self.leftMenuViewController beginAppearanceTransition:true animated:true];
            self.leftMenuVisible = true;
            leftMenuViewChange = true;
            self.edgePan.enabled = NO;
            self.pan.enabled = true;
        }
        
    } else {
        transform = CGAffineTransformIdentity;
        animationTimeLong = point.x / width/6*5 * self.animationTime;
        if (self.leftMenuVisible) {
            [self.leftMenuViewController beginAppearanceTransition:false animated:true];
            self.leftMenuVisible = NO;
            leftMenuViewChange = true;
            self.pan.enabled = NO;
            self.edgePan.enabled = true;
        }
    }
    
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [UIView animateWithDuration:animationTimeLong animations:^{
        self.contentViewContainer.transform = transform;
    } completion:^(BOOL finished) {
        if (leftMenuViewChange) {
            [self.leftMenuViewController endAppearanceTransition];
        }
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
    
}

- (void)hideLeftMenuViewController
{
    [self.leftMenuViewController beginAppearanceTransition:NO animated:true];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:self.animationTime animations:^{
        
        self.contentViewContainer.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [self.leftMenuViewController endAppearanceTransition];
        self.leftMenuVisible = NO;
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.menuViewContainer];
    [self.view addSubview:self.contentViewContainer];

    self.backgroundImageView.frame = self.view.frame;
    if (self.imageUrl != nil) {
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageUrl]];
        imageView.frame = self.backgroundImageView.frame;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.backgroundImageView addSubview:imageView];
    }
    
    self.menuViewContainer.frame = self.view.frame;
    self.menuViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (self.leftMenuViewController) {
        [self addChildViewController:self.leftMenuViewController];
        self.leftMenuViewController.view.frame = self.view.frame;
        self.leftMenuViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.menuViewContainer addSubview:self.leftMenuViewController.view];
        [self.leftMenuViewController didMoveToParentViewController:self];
    }
    
    self.contentViewContainer.frame = self.view.frame;
    self.contentViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (self.contentViewController) {
        [self addChildViewController:self.contentViewController];
        self.contentViewController.view.frame = self.view.frame;
        self.contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentViewContainer addSubview:self.contentViewController.view];
        [self.contentViewController didMoveToParentViewController:self];
    }
    
    
}

- (void)presentLeftMenuViewController
{
    if (!self.leftMenuViewController) {
        return;
    }
    if (self.leftMenuVisible) {
        self.edgePan.enabled = true;
        self.pan.enabled = NO;
        [self hideLeftMenuViewController];
        return;
    } else {
        self.edgePan.enabled = NO;
        self.pan.enabled = true;
    }
    
    [self.leftMenuViewController beginAppearanceTransition:YES animated:YES];
    
    [UIView animateWithDuration:self.animationTime animations:^{
        CGFloat width = CGRectGetWidth(self.view.frame);
        self.contentViewContainer.transform = CGAffineTransformMakeTranslation(width/6*5,0);
    } completion:^(BOOL finished) {
        [self.leftMenuViewController endAppearanceTransition];
        self.leftMenuVisible = true;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
