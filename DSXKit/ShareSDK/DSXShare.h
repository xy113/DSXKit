//
//  DSXShare.h
//  XingWeiForIPhone
//
//  Created by songdewei on 2016/12/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DSXShareButtonItem.h"

#import "WXApi.h"
#import "WXApiObject.h"
#import "DSXShareMessage.h"

@interface DSXShare : NSObject{
    @private
    UIWindow *_window;
    UIView *_backgroundView;
    UIView *_contentView;
    UIScrollView *_scrollView;
    UIButton *_cancelButton;
}

@property(nonatomic, strong)DSXShareMessage *shareMessage;
- (instancetype)init;
- (void)show;
- (void)hide;

@end
