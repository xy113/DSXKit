//
//  DSXToolbarButton.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/8/25.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXToolbarButton.h"

@implementation DSXToolbarButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(15, 7, 20, 20);
    self.titleLabel.frame = CGRectMake(0, 28, 50, 20);
    self.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
}

@end
