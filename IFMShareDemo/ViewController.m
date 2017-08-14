//
//  ViewController.m
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/9.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "ViewController.h"
#import "HXEasyCustomShareView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(100, 100, 150, 50);
    [button1 setTitle:@"新浪分享" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(addWeiboShareView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}
/**
 *  仿新浪微博分享界面
 */
- (void)addWeiboShareView {
    //分享媒介数据源
    NSArray *shareAry = @[@{@"image":@"more_chat",
                            @"highlightedImage":@"more_chat_highlighted",
                            @"title":@"私信和群"},
                          @{@"image":@"more_weixin",
                            @"highlightedImage":@"more_weixin_highlighted",
                            @"title":@"微信好友"},
                          @{@"image":@"more_circlefriends",
                            @"highlightedImage":@"more_circlefriends_highlighted",
                            @"title":@"朋友圈"},
                          @{@"image":@"more_icon_zhifubao",
                            @"highlightedImage":@"more_icon_zhifubao_highlighted",
                            @"title":@"支付宝好友"},
                          @{@"image":@"more_icon_zhifubao_friend",
                            @"highlightedImage":@"more_icon_zhifubao_friend_highlighted",
                            @"title":@"生活圈"},
                          @{@"image":@"more_icon_qq",
                            @"highlightedImage":@"more_icon_qq_highlighted",
                            @"title":@"QQ"},
                          @{@"image":@"more_icon_qzone",
                            @"highlightedImage":@"more_icon_qzone_highlighted",
                            @"title":@"QQ空间"},
                          @{@"image":@"more_mms",
                            @"highlightedImage":@"more_mms_highlighted",
                            @"title":@"短信"},
                          @{@"image":@"more_email",
                            @"highlightedImage":@"more_email_highlighted",
                            @"title":@"邮件分享"},
                          @{@"image":@"more_icon_cardbackground",
                            @"highlightedImage":@"more_icon_cardbackground_highlighted",
                            @"title":@"设卡片背景"},
                          @{@"image":@"more_icon_collection",
                            @"title":@"收藏"},
                          @{@"image":@"more_icon_topline",
                            @"title":@"帮上头条"},
                          @{@"image":@"more_icon_link",
                            @"title":@"复制链接"},
                          @{@"image":@"more_icon_report",
                            @"title":@"举报"},
                          @{@"image":@"more_icon_back",
                            @"title":@"返回首页"}];
    
    //自定义头部
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 36)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 21, headerView.frame.size.width-32, 15)];
    label.textColor = [UIColor colorWithRed:94/255.0 green:94/255.0 blue:94/255.0 alpha:1.0];;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"分享到";
    [headerView addSubview:label];
    
    //实例化
    HXEasyCustomShareView *shareView = [[HXEasyCustomShareView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    //设置头部View 如果不设置则不显示头部
    shareView.headerView = headerView;
    //计算高度 根据第一行显示的数量和总数,可以确定显示一行还是两行,最多显示2行
    float height = [shareView getBoderViewHeight:shareAry firstCount:9];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    shareView.firstCount = 9;
    [shareView setShareAry:shareAry delegate:self];
    [self.view addSubview:shareView];
}



@end
