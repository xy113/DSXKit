//
//  DSXImagePickerController.m
//  DSXFramework
//
//  Created by songdewei on 2017/1/16.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import "DSXImagePickerController.h"

@implementation DSXImagePickerObject
@synthesize isChecked = _isChecked;

@end

@implementation DSXImagePickerControllerCell
@synthesize imageView = _imageView;
@synthesize checkBox  = _checkBox;
@synthesize maskView  = _maskView;
@synthesize isChecked = _isChecked;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.4;
        _maskView.hidden = YES;
        [self addSubview:_maskView];
        
        _checkBox = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-25, 5, 20, 20)];
        _checkBox.image = [UIImage imageWithBundleName:@"DSXUI" imageName:@"imagepicker-checkbox.png"];
        _checkBox.contentMode = UIViewContentModeScaleToFill;
        _checkBox.hidden = YES;
        _checkBox.backgroundColor = [UIColor whiteColor];
        _checkBox.layer.masksToBounds = YES;
        _checkBox.layer.cornerRadius = 10;
        [self addSubview:_checkBox];
    
        [self setChecked:NO];
    }
    return self;
}

- (void)setChecked:(BOOL)checked{
    _isChecked = checked;
    if (_isChecked) {
        _maskView.hidden = NO;
        _checkBox.hidden = NO;
    }else{
        _maskView.hidden = YES;
        _checkBox.hidden = YES;
    }
}

@end

@implementation DSXImagePickerController
@synthesize delegate = _delegate;
@synthesize maxSize = _maxSize;

- (instancetype)init{
    _viewController = [[UIViewController alloc] init];
    _viewController.view.backgroundColor = [UIColor whiteColor];
    if (self = [super initWithRootViewController:_viewController]) {
        _objectList = [NSMutableArray array];
        _selectedAssets = [NSMutableArray array];
        _assetsList = [self getAllAssetInPhotoAblumWithAscending:YES];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.toolbar.frame.size.width, self.toolbar.size.height)];
        _textLabel.font = [UIFont systemFontOfSize:14.0];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.text = @"已选择0张照片";
        [self.toolbar addSubview:_textLabel];
        [self setToolbarHidden:NO];
    }
    return self;
}

- (NSArray *)fetchAlbums{
    NSMutableArray *albums = [NSMutableArray array];
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                     subtype:PHAssetCollectionSubtypeAlbumRegular
                                                                     options:nil];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj) {
            [albums addObject:obj];
        }
    }];
    return albums;
}

- (NSString *)transformAblumTitle:(NSString *)title
{
    if ([title isEqualToString:@"Slo-mo"]) {
        return @"慢动作";
    } else if ([title isEqualToString:@"Recently Added"]) {
        return @"最近添加";
    } else if ([title isEqualToString:@"Favorites"]) {
        return @"最爱";
    } else if ([title isEqualToString:@"Recently Deleted"]) {
        return @"最近删除";
    } else if ([title isEqualToString:@"Videos"]) {
        return @"视频";
    } else if ([title isEqualToString:@"All Photos"]) {
        return @"所有照片";
    } else if ([title isEqualToString:@"Selfies"]) {
        return @"自拍";
    } else if ([title isEqualToString:@"Screenshots"]) {
        return @"屏幕快照";
    } else if ([title isEqualToString:@"Camera Roll"]) {
        return @"相机胶卷";
    }
    return nil;
}

#pragma mark - 获取相册内所有照片资源
- (NSArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending{
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    //ascending 为YES时，按照照片的创建时间升序排列;为NO时，则降序排列
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:option];
    
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAsset *asset = (PHAsset *)obj;
        //NSLog(@"照片名%@", [asset valueForKey:@"filename"]);
        [assets addObject:asset];
        DSXImagePickerObject *imageObject = [[DSXImagePickerObject alloc] init];
        imageObject.isChecked = NO;
        [_objectList addObject:imageObject];
    }];
    return assets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithStyle:DSXBarButtonItemStyleBack
                                                                                      target:self action:@selector(closeWin)];
    _viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                                         style:UIBarButtonItemStylePlain
                                                                                        target:self
                                                                                        action:@selector(didFinishPickingImages)];
    _viewController.title = @"所有照片";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:_viewController.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_collectionView registerClass:[DSXImagePickerControllerCell class] forCellWithReuseIdentifier:@"itemCell"];
    [_viewController.view addSubview:_collectionView];
    
    if (!_maxSize) {
        _maxSize = 20;
    }
}

- (void)closeWin{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didFinishPickingImages{
    if ([_selectedAssets count] == 0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"请至少选择1图片"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    }else {
        if (_delegate && [_delegate respondsToSelector:@selector(dsx_imagePickerController:didFinishPickingImage:)]) {
            for (PHAsset *asset in _selectedAssets) {
                //解析图片
                PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
                //仅显示缩略图，不控制质量显示
                /**
                 PHImageRequestOptionsResizeModeNone, //默认质量
                 PHImageRequestOptionsResizeModeFast, //加载预览图，即不太清晰
                 PHImageRequestOptionsResizeModeExact //加载高清图片，会加载的比较慢
                 */
                option.resizeMode = PHImageRequestOptionsResizeModeNone;
                option.networkAccessAllowed = YES;
                //param：targetSize 即你想要的图片尺寸，若想要原尺寸则可输入PHImageManagerMaximumSize
                [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
                    //解析出来的图片
                    [_delegate dsx_imagePickerController:self didFinishPickingImage:image];
                }];
            }
        }
        [self closeWin];
    }
}

#pragma mark - collectView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_assetsList count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake((screen_width/4)-2.00001, (screen_width/4)-2.00001);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PHAsset *asset = [_assetsList objectAtIndex:indexPath.row];
    DSXImagePickerObject *imageObject = [_objectList objectAtIndex:indexPath.row];
    DSXImagePickerControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemCell" forIndexPath:indexPath];
    //解析图片
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    //仅显示缩略图，不控制质量显示
    /**
     PHImageRequestOptionsResizeModeNone, //默认质量
     PHImageRequestOptionsResizeModeFast, //加载预览图，即不太清晰
     PHImageRequestOptionsResizeModeExact //加载高清图片，会加载的比较慢
     */
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.networkAccessAllowed = YES;
    //param：targetSize 即你想要的图片尺寸，若想要原尺寸则可输入PHImageManagerMaximumSize
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        //解析出来的图片
        cell.imageView.image = image;
    }];
    [cell setChecked:imageObject.isChecked];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PHAsset *asset = [_assetsList objectAtIndex:indexPath.row];
    DSXImagePickerObject *imageObject = [_objectList objectAtIndex:indexPath.row];
    DSXImagePickerControllerCell *cell = (DSXImagePickerControllerCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (imageObject.isChecked) {
        imageObject.isChecked = NO;
        [_selectedAssets removeObject:asset];
    }else {
        if (_maxSize) {
            if (_maxSize > [_selectedAssets count]) {
                [_selectedAssets addObject:asset];
                imageObject.isChecked = YES;
            }else {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"一次最多只能选择%ld张照片"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
                [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [self.navigationController presentViewController:alertVC animated:YES completion:nil];
            }
        }else {
            [_selectedAssets addObject:asset];
            imageObject.isChecked = YES;
        }
    }
    [cell setChecked:imageObject.isChecked];
    _textLabel.text = [NSString stringWithFormat:@"已选择%lu张照片",(unsigned long)[_selectedAssets count]];
    //NSLog(@"%@", _selectedAssets);
}

@end
