//
//  UILabel+DSXAdd.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "UILabel+DSXAdd.h"

@implementation UILabel(DSXAdd)

- (BOOL)autoLayout{
    return self.autoLayout;
}

- (void)setAutoLayout:(BOOL)autoLayout{
    self.autoLayout = autoLayout;
    if (autoLayout) {
        self.numberOfLines = 0;
        CGSize size = self.frame.size;
        CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSAttachmentAttributeName:self.font} context:nil].size;
        [self setSize:labelSize];
    }
}

@end
