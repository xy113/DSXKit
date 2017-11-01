//
//  DSXNavigationHandler.h
//  LiftCloudForIPhone
//
//  Created by songdewei on 2017/7/20.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface DSXNavigationHandler : NSObject

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *address;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate address:(NSString *)address;
- (void)goThere;
- (void)goThereWithCoordinate:(CLLocationCoordinate2D)coordinate address:(NSString *)address;

@end
