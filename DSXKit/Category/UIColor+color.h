//
//  UIColor+color.h
//  LADLihuibao
//
//  Created by Apple on 15/10/27.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(color)

+ (UIColor *)colorWithHexString:(NSString*)hex;
+ (UIColor *)colorWithHexString:(NSString*)hex withAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithImage:(NSString *)imageName;

@end
