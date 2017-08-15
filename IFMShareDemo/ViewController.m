//
//  ViewController.m
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/9.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "ViewController.h"
#import "IFMShareView.h"

@interface ViewController ()
@property(nonatomic, strong) NSMutableArray *shareArray;
@property(nonatomic, strong) NSMutableArray *functionArray;
@end

@implementation ViewController

- (NSMutableArray *)shareArray{
    if (!_shareArray) {
        _shareArray = [NSMutableArray array];
        
        [_shareArray addObject:IFMPlatformNameSms];
        [_shareArray addObject:IFMPlatformNameEmail];
        [_shareArray addObject:IFMPlatformNameSina];
        [_shareArray addObject:IFMPlatformNameWechat];
        [_shareArray addObject:IFMPlatformNameQQ];
        [_shareArray addObject:IFMPlatformNameAlipay];
    }
    return _shareArray;
}

- (NSMutableArray *)functionArray{
    if (!_functionArray) {
        _functionArray = [NSMutableArray array];
        [_functionArray addObject:[[IFMShareItem alloc] initWithImage:[UIImage imageNamed:@"function_collection"] title:@"收藏" action:^(IFMShareItem *item) {
            ALERT_MSG(@"提示",@"点击了收藏",self);
        }]];
        [_functionArray addObject:[[IFMShareItem alloc] initWithImage:[UIImage imageNamed:@"function_copy"] title:@"复制" action:^(IFMShareItem *item) {
            ALERT_MSG(@"提示",@"点击了复制",self);
        }]];
        [_functionArray addObject:[[IFMShareItem alloc] initWithImage:[UIImage imageNamed:@"function_expose"] title:@"举报" action:^(IFMShareItem *item) {
            ALERT_MSG(@"提示",@"点击了举报",self);
        }]];
        [_functionArray addObject:[[IFMShareItem alloc] initWithImage:[UIImage imageNamed:@"function_font"] title:@"调整字体" action:^(IFMShareItem *item) {
            ALERT_MSG(@"提示",@"点击了调整字体",self);
        }]];
        [_functionArray addObject:[[IFMShareItem alloc] initWithImage:[UIImage imageNamed:@"function_link"] title:@"复制链接" action:^(IFMShareItem *item) {
            ALERT_MSG(@"提示",@"点击了复制链接",self);
        }]];
        [_functionArray addObject:[[IFMShareItem alloc] initWithImage:[UIImage imageNamed:@"function_refresh"] title:@"刷新" action:^(IFMShareItem *item) {
            ALERT_MSG(@"提示",@"点击了刷新",self);
        }]];
    }
    return _functionArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showOneLineStyle:(UIButton *)sender {
    IFMShareView *shareView = [[IFMShareView alloc] initWithItems:self.shareArray itemSize:CGSizeMake(80,100) DisplayLine:YES];
    shareView = [self addShareContent:shareView];
    shareView.itemSpace = 10;
    [shareView showFromControlle:self];
}

- (IBAction)showDoubleLineStyle:(UIButton *)sender{
    IFMShareView *shareView = [[IFMShareView alloc] initWithShareItems:self.shareArray functionItems:self.functionArray itemSize:CGSizeMake(80,100)];
    shareView = [self addShareContent:shareView];
    shareView.itemSpace = 10;
    [shareView showFromControlle:self];
}

- (IBAction)showMultiLineStyle:(UIButton *)sender {
    NSMutableArray *totalArry = [NSMutableArray array];
    [totalArry addObjectsFromArray:self.shareArray];
    [totalArry addObjectsFromArray:self.functionArray];
    IFMShareView *shareView = [[IFMShareView alloc] initWithItems:totalArry itemSize:CGSizeMake(80,100) DisplayLine:NO];
    shareView = [self addShareContent:shareView];
    shareView.itemSpace = 100;
    [shareView showFromControlle:self];
}

- (IBAction)showSquaredStyle:(UIButton *)sender {
    IFMShareView *shareView = [[IFMShareView alloc] initWithItems:self.shareArray countEveryRow:4];
    shareView.itemImageSize = CGSizeMake(45, 45);
    shareView = [self addShareContent:shareView];
//    shareView.itemSpace = 10;
    [shareView showFromControlle:self];
}

- (IBAction)showHeadFootStyle:(UIButton *)sender {
    IFMShareView *shareView = [[IFMShareView alloc] initWithShareItems:self.shareArray functionItems:self.functionArray itemSize:CGSizeMake(80,100)];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, headerView.frame.size.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:51/255.0 green:68/255.0 blue:79/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"我是头部可以自定义的View";
    [headerView addSubview:label];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    footerView.backgroundColor = [UIColor clearColor];
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, headerView.frame.size.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:5/255.0 green:27/255.0 blue:40/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"我是底部可以自定义的View";
    [footerView addSubview:label];
    
    shareView.headerView = headerView;
    shareView.footerView = footerView;
    shareView = [self addShareContent:shareView];
    [shareView showFromControlle:self];
}

- (IBAction)showUserDefineStyle:(UIButton *)sender{
    IFMShareView *shareView = [[IFMShareView alloc] initWithShareItems:self.shareArray functionItems:self.functionArray itemSize:CGSizeMake(80,100)];
    [shareView.cancleButton setTitle:@"我是可以自定义的按钮" forState:UIControlStateNormal];
    shareView.middleLineColor = [UIColor redColor];
    shareView.middleLineEdgeSpace = 20;
    shareView.middleTopSpace = 10;
    shareView.middleBottomSpace = 30;
    shareView = [self addShareContent:shareView];
    [shareView showFromControlle:self];
}

//添加分享的内容
- (IFMShareView *)addShareContent:(IFMShareView *)shareView{
    [shareView addText:@"分享测试"];
    [shareView addURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [shareView addImage:[UIImage imageNamed:@"share_alipay"]];
    
    return shareView;
}

@end
