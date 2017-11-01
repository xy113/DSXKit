//
//  UIView+Toast.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/10/31.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger){
    DSXToastStyleDefault,
    DSXToastStyleSuccess,
    DSXToastStyleError,
    DSXToastStyleWarn,
    DSXToastStyleQuestion,
    DSXToastStyleInfomation
}DSXToastStyle;


NS_ASSUME_NONNULL_BEGIN
@interface UIView(toast)

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


/*活动指示器*/
//不带标题
- (void)showActivity;
//带标题
- (void)showActivityWithTitle:(nullable NSString *)title;
//隐藏指示器
- (void)hideActivity;

@end
NS_ASSUME_NONNULL_END
