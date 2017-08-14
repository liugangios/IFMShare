//
//  IFMShareView.h
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/10.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFMShareView : UIView
@property (nonatomic, strong) NSArray *shareItems;
@property (nonatomic, strong) NSArray *functionItems;

@property (nonatomic, strong) UIView *containView;//背景View(包裹各种元素的view)

@property (nonatomic, strong) UIView *bodyView;//中间View,主要放分享(去除head、foot放分享按钮的view)
@property (nonatomic, strong) UIView *middleLine;//中间线

@property (nonatomic, strong) UIView *headerView;//头部分享标题
@property (nonatomic, strong) UIView *footerView;//尾部其他自定义View

@property (nonatomic, strong) UIButton *cancleButton;//取消
@property (nonatomic, assign) BOOL showsHorizontalScrollIndicator;//是否显示滚动条


- (instancetype)initWithItems:(NSArray *)items DisplayLine:(BOOL)inLine;
- (instancetype)initWithShareItems:(NSArray *)shareItems functionItems:(NSArray *)functionItems;


- (void)showInView:(UIView *)view;

//- (void)dismissMenu:(BOOL)animated;
@end
