//
//  HWSideMenuViewController.h
//  HWSideMenu
//
//  Created by 黄文海 on 2018/1/19.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWSideMenuViewController : UIViewController

@property(nonatomic, copy)NSString* imageUrl;
@property(nonatomic, assign)double animationTime;

- (instancetype)initWithContentViewController:(UIViewController*)contentViewController
                       leftMenuViewController:(UIViewController*)leftMenuViewController;

- (void)presentLeftMenuViewController;

@end
