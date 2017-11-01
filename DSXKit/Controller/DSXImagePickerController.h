//
//  DSXImagePickerController.h
//  DSXFramework
//
//  Created by songdewei on 2017/1/16.
//  Copyright © 2017年 DashiXiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN
@interface DSXImagePickerObject : NSObject
@property(nonatomic, assign)BOOL isChecked;

@end


@interface DSXImagePickerControllerCell : UICollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setChecked:(BOOL)checked;
@property(nonatomic, readonly)UIImageView *imageView;
@property(nonatomic, readonly)UIImageView *checkBox;
@property(nonatomic, readonly)UIView *maskView;
@property(nonatomic, readonly)BOOL isChecked;

@end

@class DSXImagePickerController;
@protocol DSXImagePickerControllerDelegate <NSObject>

@optional
- (void)dsx_imagePickerController:(DSXImagePickerController *)pickerController didFinishPickingImage:(UIImage *)image;

@end

@interface DSXImagePickerController : UINavigationController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    @private
    UICollectionView *_collectionView;
    UIViewController *_viewController;
    NSArray<PHAsset *> *_assetsList;//所有资源
    NSMutableArray<PHAsset *> *_selectedAssets; //已选中资源
    NSMutableArray<DSXImagePickerObject *> *_objectList;
    UILabel *_textLabel;
}

- (instancetype)init;
@property(nonatomic, assign)NSInteger maxSize;
@property(nonatomic, nullable, weak)id<UINavigationControllerDelegate,DSXImagePickerControllerDelegate>delegate;

@end
NS_ASSUME_NONNULL_END
