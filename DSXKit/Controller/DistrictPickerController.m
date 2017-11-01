//
//  DistrictPickerController.m
//  LiftCloudForIPhone
//
//  Created by songdewei on 2017/7/18.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import "DistrictPickerController.h"

@implementation DistrictPickerController
@synthesize fid = _fid;
@synthesize level = _level;
@synthesize province = _province;
@synthesize city     = _city;
@synthesize district = _district;
@synthesize placemark = _placemark;
@synthesize tableView = _tableView;
@synthesize districtList = _districtList;
@synthesize delegate = _delegate;
@synthesize didPickedBlock = _didPickedBlock;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择地区";
    self.navigationItem.leftBarButtonItem = [DSXBarButtonItem buttonItemWithStyle:DSXBarButtonItemStyleBack
                                                                           target:self action:@selector(back)];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 0.00001)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 15)];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerView"];
    //[_tableView registerClass:[UIView class] forHeaderFooterViewReuseIdentifier:@"footerView"];
    [self.view addSubview:_tableView];
    [self loadDatasource];
    if (!_level) {
        _level = 1;
    }
    if (_level == 1) {
        [self geocode];
    }
}

- (void)back{
    [self .navigationController popViewControllerAnimated:YES];
}

- (void)geocode{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:[DSXCLLocationManager sharedManager].location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        _placemark = [placemarks lastObject];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }];
}

- (void)loadDatasource{
    if (!_fid) {
        _fid = @"0";
    }
    [DSXApi GET:@"&c=district&a=batchget" parameters:@{@"fid":_fid} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"errcode"] intValue] == 0) {
            _districtList = [responseObject objectForKey:@"data"];
            if (_level > 1) {
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            }else {
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}


#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_level == 1) {
        return 2;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_level == 1) {
        if (section == 0) {
            return 1;
        }else {
            return [_districtList count];
        }
    }else {
        return [_districtList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_level == 1) {
        if (indexPath.section == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.imageView.image = [UIImage imageNamed:@"icon-location.png"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (_placemark) {
                //显示定位到的位置
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", [_placemark administrativeArea], [_placemark locality], [_placemark subLocality]];
            }else {
                cell.textLabel.text = @"定位中...";
            }
            cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
            return cell;
        }else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            NSDictionary *dist = [_districtList objectAtIndex:indexPath.row];
            cell.textLabel.text = [dist objectForKey:@"name"];
            cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        NSDictionary *dist = [_districtList objectAtIndex:indexPath.row];
        cell.textLabel.text = [dist objectForKey:@"name"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    if (_level == 1) {
        if (indexPath.section == 0) {
            NSDictionary *distinfo;
            if (_placemark) {
                distinfo = @{@"province":[_placemark administrativeArea],
                             @"city":[_placemark locality],
                             @"district":[_placemark subLocality]};
            }else {
                distinfo = [[NSDictionary alloc] init];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(districtPicker:didPickedDistrict:)]) {
                
                [_delegate districtPicker:self didPickedDistrict:distinfo];
            }
            if (_didPickedBlock) {
                _didPickedBlock(self, distinfo);
            }
            [self back];
        }else {
            NSDictionary *dist = [_districtList objectAtIndex:indexPath.row];
            DistrictPickerController *picker = [[DistrictPickerController alloc] init];
            picker.fid = [dist objectForKey:@"id"];
            picker.province = [dist objectForKey:@"name"];
            picker.level = 2;
            picker.delegate = _delegate;
            picker.didPickedBlock = _didPickedBlock;
            [self.navigationController pushViewController:picker animated:YES];
        }
    }else if (_level == 2){
        NSDictionary *dist = [_districtList objectAtIndex:indexPath.row];
        DistrictPickerController *picker = [[DistrictPickerController alloc] init];
        picker.fid = [dist objectForKey:@"id"];
        picker.province = _province;
        picker.city = [dist objectForKey:@"name"];
        picker.level = 3;
        picker.delegate = _delegate;
        picker.didPickedBlock = _didPickedBlock;
        [self.navigationController pushViewController:picker animated:YES];
    }else if (_level == 3){
        NSDictionary *dist = [_districtList objectAtIndex:indexPath.row];
        _district = [dist objectForKey:@"name"];
        NSDictionary *distinfo = @{@"province":_province, @"city":_city, @"district":_district};
        if (_delegate && [_delegate respondsToSelector:@selector(districtPicker:didPickedDistrict:)]) {
            [_delegate districtPicker:self didPickedDistrict:distinfo];
        }
        if (_didPickedBlock) {
            _didPickedBlock(self, distinfo);
        }
        NSInteger index = [[self.navigationController viewControllers] count] - _level;
        UIViewController *vc = [[self.navigationController viewControllers] objectAtIndex:index-1];
        [self.navigationController popToViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 33.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_level > 1) {
        return @"全部";
    }else {
        if (section == 0) {
            return @"定位到的位置";
        }else {
            return @"全部";
        }
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
//    headerView.textLabel.font = [UIFont systemFontOfSize:14.0f];
//    if (_level > 1) {
//        headerView.textLabel.text = @"全部";
//    }else {
//        if (section == 0) {
//            headerView.textLabel.text = @"定位到的位置";
//        }else {
//            headerView.textLabel.text = @"全部";
//        }
//    }
//    return headerView;
//}

@end
