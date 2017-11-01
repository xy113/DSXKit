//
//  UINavigationController+style.h
//  XingWeiForIPhone
//
//  Created by Apple on 16/9/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,DSXNavigationStyle){
    DSXNavigationStyleDefault,
    DSXNavigationStyleGreen,
    DSXNavigationStyleWite,
    DSXNavigationStyleDark,
    DSXNavigationStyleBlue,
    DSXNavigationStyleOrange,
    DSXNavigationStyleTransparent
};

@interface UINavigationController(style)

- (void)setStyle:(DSXNavigationStyle)style;

@end
