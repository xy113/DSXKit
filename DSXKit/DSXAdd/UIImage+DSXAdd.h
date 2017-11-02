//
//  UIImage+Bundle.h
//  LiftCloudForIPhone
//
//  Created by songdewei on 2017/7/18.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(DSXAdd)

+ (UIImage *)imageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName;

//按比例重设图片尺寸
- (UIImage *)scaleToSize:(CGSize)size;
//压缩图片
- (UIImage *)compressToSize:(CGSize)size;

@end
