//
//  DSXCLLocationManager.h
//  XiangBaLao
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface DSXCLLocationManager : CLLocationManager

- (instancetype)init;
+ (instancetype)sharedManager;
- (CLLocationCoordinate2D)coordinate;
- (NSString *)getLocationString;

@end
