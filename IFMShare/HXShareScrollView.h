//
//  HXShareScrollView.h
//  IT小子
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.
//


#import <UIKit/UIKit.h>

@class HXShareScrollView;

@protocol HXShareScrollViewDelegate <NSObject>

- (void)shareScrollViewButtonAction:(HXShareScrollView *)shareScrollView title:(NSString *)title;

@end

@interface HXShareScrollView : UIScrollView

@property (nonatomic,assign) id<HXShareScrollViewDelegate> myDelegate;
@property (nonatomic,assign) float originX;//ico起点X坐标
@property (nonatomic,assign) float originY;//ico起点Y坐标
@property (nonatomic,assign) float icoWidth;//正方形图标宽度
@property (nonatomic,assign) float icoAndTitleSpace;//图标和标题间的间隔
@property (nonatomic,assign) float titleSize;//标签字体大小
@property (nonatomic,strong) UIColor *titleColor;//标签字体颜色
@property (nonatomic,assign) float lastlySpace;//尾部间隔
@property (nonatomic,assign) float horizontalSpace;//横向间距

- (void)setShareAry:(NSArray *)shareAry delegate:(id)delegate;
+ (float)getShareScrollViewHeight;

@end