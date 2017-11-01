//
//  DSXNavigationHandler.m
//  LiftCloudForIPhone
//
//  Created by songdewei on 2017/7/20.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import "DSXNavigationHandler.h"

@implementation DSXNavigationHandler
@synthesize coordinate = _coordinate;
@synthesize address = _address;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate address:(NSString *)address{
    if (self = [super init]) {
        _coordinate = coordinate;
        _address = address;
    }
    return self;
}

- (void)goThere{
    [self goThereWithCoordinate:_coordinate address:_address];
}

- (void)goThereWithCoordinate:(CLLocationCoordinate2D)coordinate address:(NSString *)address{
    NSString *lng = [NSString stringWithFormat:@"%f", coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f", coordinate.latitude];
    if ([self canOpenUrl:@"iosamap://"]) {///跳转高德地图
        NSString *urlString = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%@&lon=%@&dev=0&style=2",@"神骑出行",@"TrunkHelper",lat, lng];
        urlString = [urlString urlencode];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{UIApplicationOpenURLOptionsOpenInPlaceKey:@"1"} completionHandler:nil];
        return;
    }else if ([self canOpenUrl:@"baidumap://"]) {///跳转百度地图
        NSString *urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name=%@&mode=driving&coord_type=bd09ll",lat, lng, address];
        urlString = [urlString urlencode];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{UIApplicationOpenURLOptionsOpenInPlaceKey:@"1"} completionHandler:nil];
        return;
    }else{////跳转系统地图
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
        MKMapItem *myLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:placemark];
        [MKMapItem openMapsWithItems:@[myLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        return;
        
    }
}

-(BOOL)canOpenUrl:(NSString *)string {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:string]];
}

@end
