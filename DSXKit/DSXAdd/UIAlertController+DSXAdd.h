//
//  UIAlertController+DSXAdd.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIAlertController(DSXAdd)

- (void)addActionWithTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler;

@end
NS_ASSUME_NONNULL_END
