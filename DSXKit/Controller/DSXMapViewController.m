//
//  DSXMapViewController.m
//  XiangBaLao
//
//  Created by Apple on 16/2/2.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXMapViewController.h"

@implementation DSXMapViewController
@synthesize province = _province;
@synthesize city     = _city;
@synthesize address  = _address;
@synthesize mapView  = _mapView;
@synthesize longitude = _longitude;
@synthesize latitude  = _latitude;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"地图"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithStyle:DSXBarButtonItemStyleBack
                                                                           target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemWithStyle:DSXBarButtonItemStyleMore
                                                                            target:self action:nil];
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mapView];
    
    if ([_longitude length] > 0 && [_latitude length] > 0) {
        [self markPlaceWithLocation];
    }else {
        [self markPlaceWithAddress];
    }
}

- (void)back{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)markPlaceWithLocation{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[_latitude floatValue] longitude:[_longitude floatValue]];
    DSXAnnotation *annotation = [[DSXAnnotation alloc] init];
    annotation.title = [NSString stringWithFormat:@"%@ %@",_province,_city];
    annotation.subtitle = _address;
    annotation.coordinate = [location coordinate];
    [_mapView addAnnotation:annotation];
    [_mapView selectAnnotation:annotation animated:YES];
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion regin = MKCoordinateRegionMake([location coordinate], span);
    [_mapView setRegion:regin animated:YES];
}


- (void)markPlaceWithAddress{
    _geocoder = [[CLGeocoder alloc] init];
    CLRegion *region = [[CLRegion alloc] init];
    [_geocoder geocodeAddressString:[NSString stringWithFormat:@"%@ %@ %@",_province,_city,_address] inRegion:region completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placeMark = [placemarks firstObject];
            CLLocation *location = placeMark.location;
            
            DSXAnnotation *annotation = [[DSXAnnotation alloc] init];
            annotation.title = [NSString stringWithFormat:@"%@ %@",_province,_city];
            annotation.subtitle = _address;
            annotation.coordinate = [location coordinate];
            [_mapView addAnnotation:annotation];
            [_mapView selectAnnotation:annotation animated:YES];
            
            MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
            MKCoordinateRegion regin = MKCoordinateRegionMake([location coordinate], span);
            [_mapView setRegion:regin animated:YES];
        }else {
        }
        
    }];
    
    /*
     [_geocoder reverseGeocodeLocation:_myLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
     if ([placemarks count] > 0) {
     NSDictionary *placeDict = [[placemarks firstObject] addressDictionary];
     NSDictionary *addressDict = @{@"City":[placeDict objectForKey:@"City"],@"Country":[placeDict objectForKey:@"Country"],@"Thoroughfare":_address};
     [_geocoder geocodeAddressDictionary:addressDict completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
     CLPlacemark *placeMark = [placemarks firstObject];
     CLLocation *location = placeMark.location;
     
     MyAnnotation *annotation = [[MyAnnotation alloc] init];
     annotation.title = _address;
     annotation.subtitle = [NSString stringWithFormat:@"%@ %@",[placeDict objectForKey:@"State"],[placeDict objectForKey:@"City"]];
     annotation.coordinate = [location coordinate];
     [_mapView addAnnotation:annotation];
     
     MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
     MKCoordinateRegion regin = MKCoordinateRegionMake([location coordinate], span);
     [_mapView setRegion:regin animated:YES];
     
     }];
     }else {
     [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleDefault Message:[NSString stringWithFormat:@"%@定位失败",_address]];
     MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
     MKCoordinateRegion regin = MKCoordinateRegionMake([_myLocation coordinate], span);
     [_mapView setRegion:regin animated:YES];
     }
     }];
     */
}

#pragma mark - 根据地名确定地理坐标
-(void)getCoordinateByAddress:(NSString *)address{
    //地理编码
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark=[placemarks firstObject];
        
        CLLocation *location=placemark.location;//位置
        CLRegion *region=placemark.region;//区域
        NSDictionary *addressDic= placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
        //        NSString *name=placemark.name;//地名
        //        NSString *thoroughfare=placemark.thoroughfare;//街道
        //        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
        //        NSString *locality=placemark.locality; // 城市
        //        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
        //        NSString *administrativeArea=placemark.administrativeArea; // 州
        //        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
        //        NSString *postalCode=placemark.postalCode; //邮编
        //        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
        //        NSString *country=placemark.country; //国家
        //        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
        //        NSString *ocean=placemark.ocean; // 海洋
        //        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
        NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
    }];
}

#pragma mark - mapView delegate

@end
