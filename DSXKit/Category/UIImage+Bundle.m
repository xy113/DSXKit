//
//  UIImage+Bundle.m
//  LiftCloudForIPhone
//
//  Created by songdewei on 2017/7/18.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import "UIImage+Bundle.h"

@implementation UIImage(Bundle)

+ (UIImage *)imageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName{
    NSString *path = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    return [UIImage imageWithContentsOfFile:[path stringByAppendingFormat:@"/%@", imageName]];
}

@end
