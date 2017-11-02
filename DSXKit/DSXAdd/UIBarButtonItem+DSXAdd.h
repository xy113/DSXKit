//
//  UIBarButtonItem+DSXAdd.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+DSXAdd.h"

typedef NS_ENUM(NSInteger, DSXBarButtonItemStyle) {
    DSXBarButtonItemStyleAdd,
    DSXBarButtonItemStyleBack,
    DSXBarButtonItemStyleClose,
    DSXBarButtonItemStyleDelete,
    DSXBarButtonItemStyleFavor,
    DSXBarButtonItemStyleLike,
    DSXBarButtonItemStyleMore,
    DSXBarButtonItemStyleMessage,
    DSXBarButtonItemStyleRefresh,
    DSXBarButtonItemStyleShare,
    DSXBarButtonItemStyleSearch,
    DSXBarButtonItemStyleScan,
};

NS_ASSUME_NONNULL_BEGIN
@interface UIBarButtonItem(DSXAdd)

+ (instancetype)buttonItemWithImage:(nullable NSString *)imageName target:(nullable id)target action:(nullable SEL)action;
+ (instancetype)buttonItemWithStyle:(DSXBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action;

@end
NS_ASSUME_NONNULL_END
