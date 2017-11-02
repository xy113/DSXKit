//
//  DSXDatePickerController.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

//定义屏幕宽度
#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif
//定义屏幕高度
#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif

#import <UIKit/UIKit.h>

@interface DSXDatePickerController : UIViewController

@property(nonatomic, readonly)UIView *contentView;
@property(nonatomic, readonly)UIToolbar *toolbar;
@property(nonatomic, readonly)UIDatePicker *datePicker;
@property(nonatomic, readwrite)NSDate *date;
@property(nonatomic, copy) void (^onPickerDidShowBlock)(DSXDatePickerController *picker);
@property(nonatomic, copy) void (^onPickerDidCloseBlock)(DSXDatePickerController *picker);
@property(nonatomic, copy) void (^onPickerDidPickedDateBlock)(DSXDatePickerController *picker, NSDate *date);

- (void)close;

@end
