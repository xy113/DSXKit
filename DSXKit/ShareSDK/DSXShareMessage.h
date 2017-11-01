//
//  DSXShareMessage.h
//  XingWeiForIPhone
//
//  Created by songdewei on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSXShareMessage : NSObject

@property(nonatomic, retain)NSString *title;
@property(nonatomic, retain)NSString *description;
@property(nonatomic, retain)NSString *pageUrl;
@property(nonatomic, retain)NSString *imageUrl;
@property(nonatomic, retain)UIImage *thumbImage;

@end
