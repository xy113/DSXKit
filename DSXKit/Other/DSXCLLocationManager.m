//
//  DSXCLLocationManager.m
//  XiangBaLao
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXCLLocationManager.h"

@implementation DSXCLLocationManager
- (instancetype)init{
    if (self = [super init]) {
        [self requestWhenInUseAuthorization];
        [self requestAlwaysAuthorization];
    }
    return self;
}
+ (instancetype)sharedManager{
    static id instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[DSXCLLocationManager alloc] init];
    });
    return instance;
}

- (CLLocationCoordinate2D)coordinate{
    return [[self location] coordinate];
}

- (NSString *)getLocationString{
    CLLocationCoordinate2D coordinate = [self coordinate];
    return [NSString stringWithFormat:@"%f,%f", coordinate.longitude, coordinate.latitude];
}

@end
