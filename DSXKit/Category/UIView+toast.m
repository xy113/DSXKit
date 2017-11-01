//
//  UIView+Toast.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/10/31.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "UIView+toast.h"

static const NSString *DSXToastViewKey = @"DSXToastViewKey";
static const NSString *DSXActivityViewKey = @"DSXActivityViewKey";

@implementation UIView(toast)

- (void)showToast:(NSString *)message{
    [self showToast:message duration:2.0 completion:nil];
}

- (void)showToast:(NSString *)message duration:(NSTimeInterval)duration{
    [self showToast:message duration:duration completion:nil];
}

- (void)showToast:(NSString *)message duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion{
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.font = [UIFont systemFontOfSize:14.0f];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.text = message;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.preferredMaxLayoutWidth = 200.0f;
    messageLabel.numberOfLines = 0;
    messageLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [messageLabel sizeToFit];
    if (messageLabel.width > 200) {
        CGSize size = [message boundingRectWithSize:CGSizeMake(200, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:messageLabel.font} context:nil].size;
        [messageLabel setSize:size];
    }
    
    UIView *toastView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, messageLabel.width+30, messageLabel.height+24)];
    toastView.layer.opacity = 0;
    toastView.layer.backgroundColor = [UIColor blackColor].CGColor;
    toastView.layer.masksToBounds = YES;
    toastView.layer.cornerRadius = 5.0f;
    toastView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    toastView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:toastView];
    objc_setAssociatedObject(self, &DSXToastViewKey, toastView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [toastView addSubview:messageLabel];
    [messageLabel setCenter:CGPointMake(toastView.width/2, toastView.height/2)];
    
    [UIView animateWithDuration:0.4 animations:^{
        toastView.layer.opacity = 0.85;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                toastView.layer.opacity = 0;
                [toastView removeFromSuperview];
            } completion:^(BOOL finished) {
                if (completion) {
                    completion(finished);
                }
            }];
        });
    }];
}

- (void)showToast:(NSString *)message image:(UIImage *)image{
    [self showToast:message image:image duration:2 completion:nil];
}

- (void)showToast:(NSString *)message image:(UIImage *)image duration:(NSTimeInterval)duration{
    [self showToast:message image:image duration:duration completion:nil];
}

- (void)showToast:(NSString *)message image:(UIImage *)image duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion{
    if (image == nil) {
        image = [UIImage imageWithBundleName:@"DSXUI" imageName:@"icon-success"];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    imageView.tintColor = [UIColor whiteColor];
    imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.font = [UIFont systemFontOfSize:14.0f];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.text = message;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.preferredMaxLayoutWidth = 200.0f;
    messageLabel.numberOfLines = 0;
    messageLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [messageLabel sizeToFit];
    if (messageLabel.width > 200) {
        CGSize size = [message boundingRectWithSize:CGSizeMake(200, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:messageLabel.font} context:nil].size;
        [messageLabel setSize:size];
    }
    
    CGFloat contentWidth = messageLabel.width > imageView.width ? messageLabel.width : imageView.width;
    CGFloat contentHeight = imageView.height + messageLabel.height + 5;
    UIView *toastView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentWidth+30, contentHeight+35)];
    toastView.layer.opacity = 0;
    toastView.layer.backgroundColor = [UIColor blackColor].CGColor;
    toastView.layer.masksToBounds = YES;
    toastView.layer.cornerRadius = 5.0f;
    toastView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    toastView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:toastView];
    objc_setAssociatedObject(self, &DSXToastViewKey, toastView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //添加图标
    [toastView addSubview:imageView];
    [imageView setCenter:CGPointMake(toastView.width/2, 35)];
    
    [toastView addSubview:messageLabel];
    [messageLabel setCenter:CGPointMake(toastView.width/2, toastView.height - messageLabel.height/2 -15)];
    [UIView animateWithDuration:0.4 animations:^{
        toastView.layer.opacity = 0.85;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.6 animations:^{
                toastView.layer.opacity = 0;
                [toastView removeFromSuperview];
            } completion:^(BOOL finished) {
                if (completion) {
                    completion(finished);
                }
            }];
        });
    }];
}

- (void)showToast:(NSString *)message style:(DSXToastStyle)style{
    [self showToast:message style:style duration:2 completion:nil];
}

- (void)showToast:(NSString *)message style:(DSXToastStyle)style duration:(NSTimeInterval)duration{
    [self showToast:message style:style duration:duration completion:nil];
}

- (void)showToast:(NSString *)message style:(DSXToastStyle)style duration:(NSTimeInterval)duration completion:(nullable void (^)(BOOL))completion{
    UIImage *image;
    switch (style) {
            case DSXToastStyleSuccess:
            image = [UIImage imageNamed:@"DSXUI.bundle/toast-success"];
            break;
            
            case DSXToastStyleError:
            image = [UIImage imageNamed:@"DSXUI.bundle/toast-error"];
            break;
            
            case DSXToastStyleQuestion:
            image = [UIImage imageNamed:@"DSXUI.bundle/toast-question"];
            break;
            
            case DSXToastStyleInfomation:
            image = [UIImage imageNamed:@"DSXUI.bundle/toast-infomation"];
            break;
            
            case DSXToastStyleWarn:
            image = [UIImage imageNamed:@"DSXUI.bundle/toast-warn"];
            break;
            
        default:
            image = [UIImage imageNamed:@"DSXUI.bundle/toast-success"];
            break;
    }
    [self showToast:message image:image duration:duration completion:completion];
}

- (void)showActivity{
    [self showActivityWithTitle:nil];
}

- (void)showActivityWithTitle:(NSString *)title{
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    UIView *activityView = [[UIView alloc] init];
    activityView.layer.opacity = 0;
    activityView.layer.backgroundColor = [UIColor blackColor].CGColor;
    activityView.layer.masksToBounds = YES;
    activityView.layer.cornerRadius = 5.0f;
    activityView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:activityView];
    //设置属性
    objc_setAssociatedObject(self, &DSXActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //添加指示器
    [activityView addSubview:indicatorView];
    
    CGFloat width,height;
    if (title != nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.preferredMaxLayoutWidth = 120.0f;
        titleLabel.numberOfLines = 0;
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [titleLabel sizeToFit];
        if (titleLabel.width > 120) {
            CGSize size = [title boundingRectWithSize:CGSizeMake(120, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLabel.font} context:nil].size;
            [titleLabel setSize:size];
        }
        [activityView addSubview:titleLabel];
        
        width = titleLabel.width > indicatorView.width ? titleLabel.width : indicatorView.width;
        height = indicatorView.height + titleLabel.height;
        [activityView setSize:CGSizeMake(width+40, height+50)];
        indicatorView.center = CGPointMake(activityView.width/2, indicatorView.height/2+20);
        titleLabel.center = CGPointMake(activityView.width/2, activityView.height - titleLabel.height/2 - 20);
        
    }else {
        width = indicatorView.width;
        height = indicatorView.height;
        [activityView setSize:CGSizeMake(width+40, height+40)];
        indicatorView.center = CGPointMake(activityView.width/2, indicatorView.height/2+20);
    }
    activityView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    //显示动画
    [UIView animateWithDuration:0.4 animations:^{
        activityView.layer.opacity = 0.85;
    } completion:^(BOOL finished) {
        [indicatorView startAnimating];
    }];
}

- (void)hideActivity{
    UIView *indicatorView = objc_getAssociatedObject(self, &DSXActivityViewKey);
    [UIView animateWithDuration:0.2 animations:^{
        indicatorView.layer.opacity = 0;
        [indicatorView removeFromSuperview];
    }];
}

@end
