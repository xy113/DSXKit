//
//  DSXBarButtonItem.m
//  LiftCloudForIPhone
//
//  Created by songdewei on 2017/7/21.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import "DSXBarButtonItem.h"

@implementation DSXBarButtonItem
@synthesize itemStyle = _itemStyle;

- (instancetype)initWithStyle:(DSXBarButtonItemStyle)style target:(id)target action:(SEL)action{
    _itemStyle = style;
    return [super initWithImage:[self getImageWithStyle:style] style:UIBarButtonItemStylePlain target:target action:action];
}

+ (instancetype)buttonItemWithImage:(NSString *)imageName target:(id)target action:(SEL)action{
    return [[DSXBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName]
                                             style:UIBarButtonItemStylePlain
                                            target:target
                                            action:action];
}

+ (instancetype)buttonItemWithStyle:(DSXBarButtonItemStyle)style target:(id)target action:(SEL)action{
    return [[DSXBarButtonItem alloc] initWithStyle:style target:target action:action];
}

- (void)setItemStyle:(DSXBarButtonItemStyle)itemStyle{
    _itemStyle = itemStyle;
    [self setImage:[self getImageWithStyle:itemStyle]];
}

- (UIImage *)getImageWithStyle:(DSXBarButtonItemStyle)style{
    NSString *imageName;
    switch (style) {
        case DSXBarButtonItemStyleAdd:
            imageName = @"icon-add.png";
            break;
        case DSXBarButtonItemStyleBack:
            imageName = @"icon-back.png";
            break;
        case DSXBarButtonItemStyleClose:
            imageName = @"icon-close.png";
            break;
        case DSXBarButtonItemStyleDelete:
            imageName = @"icon-delete.png";
            break;
        case DSXBarButtonItemStyleFavor:
            imageName = @"icon-favor.png";
            break;
        case DSXBarButtonItemStyleLike:
            imageName = @"icon-like.png";
            break;
        case DSXBarButtonItemStyleMore:
            imageName = @"icon-more.png";
            break;
        case DSXBarButtonItemStyleMessage:
            imageName = @"icon-message.png";
            break;
        case DSXBarButtonItemStyleRefresh:
            imageName = @"icon-refresh.png";
            break;
        case DSXBarButtonItemStyleShare:
            imageName = @"icon-share.png";
            break;
        case DSXBarButtonItemStyleSearch:
            imageName = @"icon-search.png";
            break;
        case DSXBarButtonItemStyleScan:
            imageName = @"icon-scan.png";
            break;
        default: imageName = @"icon-more.png";
            break;
    }
    return [UIImage imageWithBundleName:@"DSXUI" imageName:imageName];
}

@end
