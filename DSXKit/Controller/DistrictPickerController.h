//
//  DistrictPickerController.h
//  LiftCloudForIPhone
//
//  Created by songdewei on 2017/7/18.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSXCLLocationManager.h"

@class DistrictPickerController;
@protocol DistrictPickerControllerDelegate <NSObject>

@optional
- (void)districtPicker:(DistrictPickerController *)picker didPickedDistrict:(NSDictionary *)distinfo;

@end

@interface DistrictPickerController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

}

@property(nonatomic, strong) NSString *fid; //父级ID
@property(nonatomic, assign) NSInteger level; //行政级别
@property(nonatomic, strong) NSString *province; //省
@property(nonatomic, strong) NSString *city; //市
@property(nonatomic, strong) NSString *district; //县
@property(nonatomic, retain) CLPlacemark *placemark; //当前位置
@property(nonatomic, readonly) UITableView *tableView;
@property(nonatomic, readonly) NSArray *districtList;
@property(nonatomic, assign)id<DistrictPickerControllerDelegate>delegate;
@property(nonatomic, copy) void (^didPickedBlock)(DistrictPickerController *picker, NSDictionary *info);

@end
