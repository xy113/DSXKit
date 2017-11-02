//
//  UINavigationController+style.m
//  XingWeiForIPhone
//
//  Created by Apple on 16/9/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UINavigationController+style.h"

@implementation UINavigationController(style)

- (void)setStyle:(DSXNavigationStyle)style{
    switch (style) {
        case DSXNavigationStyleWite:
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"white.png"] forBarMetrics:UIBarMetricsDefault];
            [self.navigationBar setShadowImage:nil];
            [self.navigationBar setTintColor:[UIColor colorWithHexString:@"#666666"]];
            [self.navigationBar setBarStyle:UIBarStyleDefault];
            break;
        case DSXNavigationStyleGreen:
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"green.png"] forBarMetrics:UIBarMetricsDefault];
            [self.navigationBar setShadowImage:[UIImage imageNamed:@"transparent.png"]];
            [self.navigationBar setTintColor:[UIColor whiteColor]];
            [self.navigationBar setBarStyle:UIBarStyleBlack];
            break;
        case DSXNavigationStyleDark:
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_dark.png"] forBarMetrics:UIBarMetricsDefault];
            [self.navigationBar setShadowImage:[UIImage imageNamed:@"transparent.png"]];
            [self.navigationBar setTintColor:[UIColor whiteColor]];
            [self.navigationBar setBarStyle:UIBarStyleBlack];
            break;
        case DSXNavigationStyleBlue:
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_blue.png"] forBarMetrics:UIBarMetricsDefault];
            [self.navigationBar setShadowImage:[UIImage imageNamed:@"transparent.png"]];
            [self.navigationBar setTintColor:[UIColor whiteColor]];
            [self.navigationBar setBarStyle:UIBarStyleBlack];
            break;
        case DSXNavigationStyleOrange:
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_orange.png"] forBarMetrics:UIBarMetricsDefault];
            [self.navigationBar setShadowImage:[UIImage imageNamed:@"transparent.png"]];
            [self.navigationBar setTintColor:[UIColor whiteColor]];
            [self.navigationBar setBarStyle:UIBarStyleBlack];
            break;
        case DSXNavigationStyleTransparent:
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"transparent.png"] forBarMetrics:UIBarMetricsDefault];
            [self.navigationBar setShadowImage:[UIImage imageNamed:@"transparent.png"]];
            [self.navigationBar setTintColor:[UIColor whiteColor]];
            [self.navigationBar setBarStyle:UIBarStyleBlack];
            break;
            
        default:
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"white.png"] forBarMetrics:UIBarMetricsDefault];
            [self.navigationBar setShadowImage:nil];
            [self.navigationBar setTintColor:[UIColor colorWithHexString:@"#666666"]];
            [self.navigationBar setBarStyle:UIBarStyleDefault];
            break;
    }
}

@end
