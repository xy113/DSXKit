//
//  DSXTextView.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/9/6.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+color.h"
#import "UIView+Size.h"

@interface DSXTextView : UITextView

@property(nonatomic, readonly) UILabel *placeHolderLabel;
@property(nonatomic, strong) NSString *placeHolder;
- (instancetype)initWithFrame:(CGRect)frame;

@end
