//
//  DSXShareButtonItem.m
//  XingWeiForIPhone
//
//  Created by songdewei on 2016/12/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXShareButtonItem.h"

@implementation DSXShareButtonItem

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake((self.frame.size.width-50)/2, 0, 50, 50);
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 25.0f;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    self.titleLabel.frame = CGRectMake(0, 55, self.frame.size.width, 20);
    self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
