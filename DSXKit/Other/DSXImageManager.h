//
//  DSXImageManager.h
//  DSXFramework
//
//  Created by songdewei on 2016/12/5.
//  Copyright © 2016年 DashiXiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface DSXImageManager : NSObject

+ (instancetype)sharedManager;
+ (UIImage *)scaleImage:(UIImage *)sourceImage toSize:(CGSize)size;
+ (UIImage *)compressImage:(UIImage *)sourceImage toSize:(CGSize)size;

@end
