//
//  DSXDatePicker.h
//  XingWeiForIPhone
//
//  Created by songdewei on 2016/12/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

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
