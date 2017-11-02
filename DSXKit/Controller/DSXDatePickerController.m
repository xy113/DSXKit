//
//  DSXDatePickerController.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXDatePickerController.h"

@implementation DSXDatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //半透明背景
    self.view.backgroundColor = [UIColor colorWithImage:@"DSXKit.bundle/translucent-60.png"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tap];
    [self.view setUserInteractionEnabled:YES];
    //内容视图
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
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

- (void)viewDidAppear:(BOOL)animated{
    [self show];
}

- (void)setDate:(NSDate *)date{
    _date = date;
    [_datePicker setDate:date animated:YES];
}

- (void)show{
    [UIView animateWithDuration:0.3f animations:^{
        _contentView.top = SCREEN_HEIGHT - 250;
    } completion:^(BOOL finished) {
        if (_onPickerDidShowBlock) {
            _onPickerDidShowBlock(self);
        }
    }];
}

- (void)close{
    [UIView animateWithDuration:0.2 animations:^{
        _contentView.top = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        if (_onPickerDidCloseBlock) {
            _onPickerDidCloseBlock(self);
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)onPicked{
    _date = _datePicker.date;
    if (_onPickerDidPickedDateBlock) {
        _onPickerDidPickedDateBlock(self, _date);
    }
    [self close];
}

@end
