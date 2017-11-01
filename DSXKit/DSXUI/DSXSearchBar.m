//
//  DSXSearchBar.m
//  XingWeiForIPhone
//
//  Created by Apple on 16/8/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXSearchBar.h"

@implementation DSXSearchBar
@synthesize textField = _textField;
@synthesize textColor = _textColor;
@synthesize placeHolderColor = _placeHolderColor;

- (instancetype)init{
    return [[[self class] alloc] initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBarTintColor:[UIColor clearColor]];
        for (UIView *subview in self.subviews) {
            for (UIView *view in subview.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                    [view removeFromSuperview];
                }
                if ([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                    _textField = (UITextField *)view;
                    _textField.font = [UIFont systemFontOfSize:14.0];
                    break;
                }else {
                    [view removeFromSuperview];
                }
            }
        }
        self.height = 30;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [_textField setTextColor:textColor];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor = placeHolderColor;
    [_textField setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.height = 44;
    self.textField.height = 30;
    self.textField.originY = 6;
    self.textField.layer.masksToBounds = YES;
    self.textField.layer.cornerRadius = 15.0;
    self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (CGSize)intrinsicContentSize{
    return CGSizeMake(SCREEN_WIDTH, 44);
}

@end
