//
//  UIViewController.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/10/31.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "UIViewController+toast.h"

@implementation UIViewController(toast)

- (void)showToast:(NSString *)message{
    [self.view showToast:message];
}

- (void)showToast:(NSString *)message duration:(NSTimeInterval)duration{
    [self.view showToast:message duration:duration];
}

- (void)showToast:(NSString *)message duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion{
    [self.view showToast:message duration:duration completion:completion];
}

- (void)showToast:(NSString *)message image:(UIImage *)image{
    [self.view showToast:message image:image];
}

- (void)showToast:(NSString *)message image:(UIImage *)image duration:(NSTimeInterval)duration{
    [self.view showToast:message image:image duration:duration];
}

- (void)showToast:(NSString *)message image:(UIImage *)image duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion{
    [self.view showToast:message image:image duration:duration completion:completion];
}

- (void)showToast:(NSString *)message style:(DSXToastStyle)style{
    [self.view showToast:message style:style];
}

- (void)showToast:(NSString *)message style:(DSXToastStyle)style duration:(NSTimeInterval)duration{
    [self.view showToast:message style:style duration:duration];
}

- (void)showToast:(NSString *)message style:(DSXToastStyle)style duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion{
    [self.view showToast:message style:style duration:duration completion:completion];
}

- (void)showActivity{
    [self.view showActivity];
}

- (void)showActivityWithTitle:(NSString *)title{
    [self.view showActivityWithTitle:title];
}

- (void)hideActivity{
    [self.view hideActivity];
}

@end
