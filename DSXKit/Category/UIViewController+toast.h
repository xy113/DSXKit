//
//  UIViewController.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/10/31.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+toast.h"

NS_ASSUME_NONNULL_BEGIN
@interface UIViewController(toast)

/*Toast*/
- (void)showToast:(NSString *)message;

- (void)showToast:(NSString *)message
         duration:(NSTimeInterval)duration;

- (void)showToast:(NSString *)message
         duration:(NSTimeInterval)duration
       completion:(nullable void (^)(BOOL))completion;

- (void)showToast:(NSString *)message
            image:(nullable UIImage *)image;

- (void)showToast:(NSString *)message
            image:(nullable UIImage *)image
         duration:(NSTimeInterval)duration;

- (void)showToast:(NSString *)message
            image:(nullable UIImage *)image
         duration:(NSTimeInterval)duration
       completion:(nullable void (^)(BOOL))completion;

- (void)showToast:(NSString *)message
            style:(DSXToastStyle)style;

- (void)showToast:(NSString *)message
            style:(DSXToastStyle)style
         duration:(NSTimeInterval)duration;

- (void)showToast:(NSString *)message
            style:(DSXToastStyle)style
         duration:(NSTimeInterval)duration
       completion:(nullable void (^)(BOOL))completion;


- (void)showActivity;
- (void)showActivityWithTitle:(nullable NSString *)title;
- (void)hideActivity;
@end
NS_ASSUME_NONNULL_END
