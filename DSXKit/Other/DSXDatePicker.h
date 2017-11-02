//
//  DSXDatePicker.h
//  XingWeiForIPhone
//
//  Created by songdewei on 2016/12/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

//定义屏幕宽度
#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif
//定义屏幕高度
#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif
//定义顶部高度
#ifndef TOP_HEIGHT
#define TOP_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height+self.navigationController.navigationBar.frame.size.height
#endif

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIView+Size.h"

@class DSXDatePicker;
@protocol DSXDatePickerDelegate <NSObject>

@optional
- (void)dsx_datePickerAfterShow:(DSXDatePicker *)datePicker;
- (void)dsx_datePickerAfterClose:(DSXDatePicker *)datePicker;
- (void)dsx_datePicker:(DSXDatePicker *)datePicker didPickedDate:(NSDate *)date;

@end

@interface DSXDatePicker : NSObject{
    @private
    UIWindow *_window;
}

@property(nonatomic, readonly)UIView *backgroundView;
@property(nonatomic, readonly)UIView *contentView;
@property(nonatomic, readonly)UIToolbar *toolbar;
@property(nonatomic, readonly)UIDatePicker *datePicker;
@property(nonatomic, readwrite)NSDate *date;
@property(nonatomic, assign)id<DSXDatePickerDelegate>delegate;

- (instancetype)init;
- (void)showInView:(UIView *)view;
- (void)close;

@end
