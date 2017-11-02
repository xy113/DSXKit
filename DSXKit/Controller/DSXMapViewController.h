//
//  DSXMapViewController.h
//  XiangBaLao
//
//  Created by Apple on 16/2/2.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DSXAnnotation.h"
#import "UIBarButtonItem+DSXAdd.h"

@interface DSXMapViewController : UIViewController<MKMapViewDelegate>{
    @private
    CLGeocoder *_geocoder;
}

@property(nonatomic)NSString *province;
@property(nonatomic)NSString *city;
@property(nonatomic)NSString *address;
@property(nonatomic)NSString *longitude;
@property(nonatomic)NSString *latitude;
@property(nonatomic,readonly)MKMapView *mapView;

@end
