//
//  DSXNavigationController.m
//  XiangBaLao
//
//  Created by Apple on 15/12/20.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "DSXNavigationController.h"

@implementation DSXNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
        [self setStyle:DSXNavigationStyleGreen];
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.2;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    return [super popViewControllerAnimated:animated];
}

@end
