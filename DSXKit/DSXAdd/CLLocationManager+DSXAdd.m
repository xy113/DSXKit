//
//  CLLocationManager+DSXAdd.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/2.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "CLLocationManager+DSXAdd.h"

@implementation CLLocationManager(DSXAdd)

- (CLLocationCoordinate2D)coordinate{
    return [[self location] coordinate];
}

@end
