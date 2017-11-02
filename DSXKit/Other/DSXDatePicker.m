//
//  DSXDatePicker.m
//  XingWeiForIPhone
//
//  Created by songdewei on 2016/12/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXDatePicker.h"
#import "UIColor+color.h"

@implementation DSXDatePicker
@synthesize backgroundView = _backgroundView;
@synthesize contentView = _contentView;
@synthesize datePicker = _datePicker;
@synthesize toolbar = _toolbar;
@synthesize date = _date;
@synthesize delegate = _delegate;

- (instancetype)init{
    if (self = [super init]) {
        //半透明背景
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor colorWithImage:@"translucent-60.png"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [_backgroundView addGestureRecognizer:tap];
        [_backgroundView setUserInteractionEnabled:YES];
        //内容视图
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250)];
        _contentView.backgroundColor = [UIColor whiteColor];
        
        //Toolbar
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        [_contentView addSubview:_toolbar];
        
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"   取消" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确定   " style:UIBarButtonItemStylePlain target:self action:@selector(onPicked)];
        [_toolbar setItems:@[cancelItem,spaceItem,doneItem]];
        
        
        //UIDatePicker
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 200)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_contentView addSubview:_datePicker];
    }
    return self;
}

- (void)setDate:(NSDate *)date{
    _date = date;
    [_datePicker setDate:date animated:YES];
}

- (void)showInView:(UIView *)view{
    _window = view.window;
    [_window addSubview:_backgroundView];
    [_window addSubview:_contentView];
    [UIView animateWithDuration:0.3f animations:^{
        _contentView.left = SCREEN_HEIGHT - 250;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)close{
    [_contentView removeFromSuperview];
    [_backgroundView removeFromSuperview];
    _contentView.left = SCREEN_HEIGHT;
    if (_delegate && [_delegate respondsToSelector:@selector(dsx_datePickerAfterClose:)]) {
        [_delegate dsx_datePickerAfterClose:self];
    }
}

- (void)onPicked{
    _date = _datePicker.date;
    if (_delegate && [_delegate respondsToSelector:@selector(dsx_datePicker:didPickedDate:)]) {
        [_delegate dsx_datePicker:self didPickedDate:_datePicker.date];
    }
    [self close];
}

@end
