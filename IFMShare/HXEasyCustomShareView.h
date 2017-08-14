//
//  HXEasyCustomShareView.h
//  HXEasyCustomShareView
//
//  Created by 黄轩 on 16/1/19.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HXOriginX 15.0 //ico起点X坐标
#define HXOriginY 15.0 //ico起点Y坐标
#define HXIcoWidth 57.0 //正方形图标宽度
#define HXIcoAndTitleSpace 10.0 //图标和标题间的间隔
#define HXTitleSize 10.0 //标签字体大小
#define HXTitleColor [UIColor colorWithRed:52/255.0 green:52/255.0 blue:50/255.0 alpha:1.0] //标签字体颜色
#define HXLastlySpace 15.0 //尾部间隔
#define HXHorizontalSpace 15.0 //横向间距

@class HXEasyCustomShareView;

@protocol HXEasyCustomShareViewDelegate <NSObject>

- (void)easyCustomShareViewButtonAction:(HXEasyCustomShareView *)shareView title:(NSString *)title;

@end

@interface HXEasyCustomShareView : UIView

@property (nonatomic,assign) id<HXEasyCustomShareViewDelegate> delegate;
@property (nonatomic,strong) UIView *backView;//背景View(包裹各种元素的view)
@property (nonatomic,strong) UIView *headerView;//头部分享标题
@property (nonatomic,strong) UIView *boderView;//中间View,主要放分享(放分享按钮的view)
@property (nonatomic,strong) UILabel *middleLineLabel;//中间线
@property (nonatomic,assign) NSInteger firstCount;//第一行分享媒介数量,分享媒介最多显示2行,如果第一行显示了全部则不显示第二行
@property (nonatomic,strong) UIView *footerView;//尾部其他自定义View
@property (nonatomic,strong) UIButton *cancleButton;//取消
@property (nonatomic,assign) BOOL showsHorizontalScrollIndicator;//是否显示滚动条

- (void)setShareAry:(NSArray *)shareAry delegate:(id)delegate;
- (float)getBoderViewHeight:(NSArray *)shareAry firstCount:(NSInteger)count;

@end
