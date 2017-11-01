//
//  DSXBarButtonItem.h
//  LiftCloudForIPhone
//
//  Created by songdewei on 2017/7/21.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import <UIKit/UIKit.h>
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
@interface DSXBarButtonItem : UIBarButtonItem

@property(nonatomic, assign) DSXBarButtonItemStyle itemStyle;

- (instancetype)initWithStyle:(DSXBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action;
+ (instancetype)buttonItemWithImage:(nullable NSString *)imageName target:(nullable id)target action:(nullable SEL)action;
+ (instancetype)buttonItemWithStyle:(DSXBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action;

@end
NS_ASSUME_NONNULL_END
