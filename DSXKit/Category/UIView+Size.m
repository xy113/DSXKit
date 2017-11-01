//
//  UIView+Size.m
//  XiangBaLao
//
//  Created by Apple on 16/1/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIView+Size.h"

@implementation UIView(size)

- (CGSize)size{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size.width  = size.width;
    frame.size.height = size.height;
    [self setFrame:frame];
}

- (CGPoint)position{
    return CGPointMake(self.frame.origin.x, self.frame.origin.y);
}

- (void)setPosition:(CGPoint)position{
    CGRect frame = self.frame;
    frame.origin.x = position.x;
    frame.origin.y = position.y;
    [self setFrame:frame];
}

- (CGFloat)originX{
    return self.frame.origin.x;
}

- (void)setOriginX:(CGFloat)originX{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}

- (CGFloat)originY{
    return self.frame.origin.y;
}

- (void)setOriginY:(CGFloat)originY{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end
