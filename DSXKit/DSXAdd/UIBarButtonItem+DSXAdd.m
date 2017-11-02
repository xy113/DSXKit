//
//  UIBarButtonItem+DSXAdd.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "UIBarButtonItem+DSXAdd.h"

@implementation UIBarButtonItem(DSXAdd)

+ (instancetype)buttonItemWithImage:(NSString *)imageName target:(id)target action:(SEL)action{
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName]
                                             style:UIBarButtonItemStylePlain
                                            target:target
                                            action:action];
}

+ (instancetype)buttonItemWithStyle:(DSXBarButtonItemStyle)style target:(id)target action:(SEL)action{
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
    UIImage *image = [UIImage imageWithBundleName:@"DSXUI" imageName:imageName];
    return [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
}

@end
