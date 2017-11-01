//
//  DSXLabel.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/10/22.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXLabel.h"

@implementation DSXLabel

- (void)setAutoLayout:(BOOL)autoLayout{
    _autoLayout = autoLayout;
    if (autoLayout) {
        CGSize size = self.frame.size;
        CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(size.width, 0) options:NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSAttachmentAttributeName:self.font} context:nil].size;
        [self setHeight:labelSize.height+5];
        [self setWidth:labelSize.width+5];
    }
}

@end
