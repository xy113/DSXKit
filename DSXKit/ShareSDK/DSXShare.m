//
//  DSXShare.m
//  XingWeiForIPhone
//
//  Created by songdewei on 2016/12/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DSXShare.h"

@implementation DSXShare
@synthesize shareMessage = _shareMessage;

- (instancetype)init{
    if (self = [super init]) {
        _window = [[[UIApplication sharedApplication] delegate] window];
        _backgroundView = [[UIView alloc] initWithFrame:_window.bounds];
        _backgroundView.backgroundColor = [UIColor colorWithImage:@"translucent-60.png"];
        _backgroundView.hidden = YES;
        [_window addSubview:_backgroundView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_backgroundView addGestureRecognizer:tap];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, _window.frame.size.height, _window.frame.size.width, 180)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.hidden = YES;
        [_window addSubview:_contentView];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, _contentView.frame.size.width, 80)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_contentView addSubview:_scrollView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 120, _contentView.frame.size.width-20, 0.5)];
        [line setBackgroundColor:[UIColor colorWithHexString:@"#DDDDDD"]];
        [_contentView addSubview:line];
        
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, _contentView.frame.size.width, 60)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_cancelButton];
        
        DSXShareButtonItem *weixinButton = [[DSXShareButtonItem alloc] initWithFrame:CGRectMake(10, 0, 80, 80)];
        [weixinButton setImage:[UIImage imageWithBundleName:@"DSXUI" imageName:@"weixin.png"] forState:UIControlStateNormal];
        [weixinButton setTitle:@"微信好友" forState:UIControlStateNormal];
        [weixinButton addTarget:self action:@selector(shareToWeixin:) forControlEvents:UIControlEventTouchUpInside];
        [weixinButton setTag:0];
        [_scrollView addSubview:weixinButton];
        
        DSXShareButtonItem *pengyouquanButton =[[DSXShareButtonItem alloc] initWithFrame:CGRectMake(100, 0, 80, 80)];
        [pengyouquanButton setImage:[UIImage imageWithBundleName:@"DSXUI" imageName:@"pengyouquan.png"] forState:UIControlStateNormal];
        [pengyouquanButton setTitle:@"微信朋友圈" forState:UIControlStateNormal];
        [pengyouquanButton addTarget:self action:@selector(shareToWeixin:) forControlEvents:UIControlEventTouchUpInside];
        [pengyouquanButton setTag:1];
        [_scrollView addSubview:pengyouquanButton];
        
        DSXShareButtonItem *qqButton = [[DSXShareButtonItem alloc] initWithFrame:CGRectMake(190, 0, 80, 80)];
        [qqButton setImage:[UIImage imageWithBundleName:@"DSXUI" imageName:@"qq.png"] forState:UIControlStateNormal];
        [qqButton setTitle:@"QQ好友" forState:UIControlStateNormal];
        [_scrollView addSubview:qqButton];
        
        DSXShareButtonItem *qzoneButton = [[DSXShareButtonItem alloc] initWithFrame:CGRectMake(280, 0, 80, 80)];
        [qzoneButton setImage:[UIImage imageWithBundleName:@"DSXUI" imageName:@"qzone.png"] forState:UIControlStateNormal];
        [qzoneButton setTitle:@"QQ空间" forState:UIControlStateNormal];
        [_scrollView addSubview:qzoneButton];
        
        DSXShareButtonItem *copyButton = [[DSXShareButtonItem alloc] initWithFrame:CGRectMake(370, 0, 80, 80)];
        [copyButton setImage:[UIImage imageWithBundleName:@"DSXUI" imageName:@"copy.png"] forState:UIControlStateNormal];
        [copyButton setTitle:@"复制链接" forState:UIControlStateNormal];
        [_scrollView addSubview:copyButton];
        [_scrollView setContentSize:CGSizeMake(460, 0)];
        
    }
    return self;
}

- (void)show{
    _backgroundView.hidden = NO;
    _contentView.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^{
        [_contentView setPosition:CGPointMake(0, _window.height-180)];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.3f animations:^{
        [_contentView setPosition:CGPointMake(0, _window.height)];
    } completion:^(BOOL finished) {
        [_contentView setHidden:YES];
        [_backgroundView setHidden:YES];
    }];
}

- (UIButton *)shareButtonWithImage:(UIImage *)image Title:(NSString *)title{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 80)];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.imageView.frame = CGRectMake(0, 0, 60, 60);
    button.imageView.layer.cornerRadius = 30.0f;
    button.imageView.layer.masksToBounds = YES;
    button.imageView.contentMode = UIViewContentModeScaleToFill;
    
    button.titleLabel.frame = CGRectMake(0, 60, 60, 20);
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    return button;
}

#pragma mark - actions
- (void)shareToWeixin:(UIButton *)button{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = _shareMessage.title;
    message.description = _shareMessage.description;
    if (_shareMessage.thumbImage) {
        [message setThumbImage:_shareMessage.thumbImage];
    }else {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_shareMessage.imageUrl]];
        UIImage *thumbTmage = [DSXImageManager compressImage:[UIImage imageWithData:imageData] toSize:CGSizeMake(100, 100)];
        [message setThumbImage:thumbTmage];
    }
    
    WXWebpageObject *pageObject = [WXWebpageObject object];
    pageObject.webpageUrl = _shareMessage.pageUrl;
    message.mediaObject = pageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    if (button.tag == 0) {
        req.scene = WXSceneSession;
    }else {
        req.scene = WXSceneTimeline;
    }
    
    [WXApi sendReq:req];
}

@end
