//
//  DSXTextView.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/9/6.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXTextView.h"

@implementation DSXTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _placeHolderLabel.textColor = [UIColor colorWithHexString:@"#C7C7CD"];
        [self insertSubview:_placeHolderLabel atIndex:0];
    }
    return self;
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    _placeHolderLabel.text = placeHolder;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _placeHolderLabel.font = self.font;
    CGSize size = [_placeHolderLabel.text boundingRectWithSize:CGSizeMake(self.width, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    _placeHolderLabel.frame = CGRectMake(0, 0, size.width, size.height);
}

@end
