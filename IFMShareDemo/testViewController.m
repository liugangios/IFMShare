//
//  testViewController.m
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/10.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "testViewController.h"
#import "IFMShareView.h"
#import "IFMShareItem.h"

@interface testViewController ()

@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    [arr addObject:IFMPlatformNameQQ];
    IFMShareItem *shareItem = [IFMShareItem itemWithImage:@"" title:@"" action:<#^(IFMShareItem *item)action#>];
    [arr addObject:shareItem];
    
    //要有一个计算collectionView高度的方法
    //默认没有头部尾部
    IFMShareView *shareView = [[IFMShareView alloc] initWithItems:arr inOneRow:YES];//是一栏显示还是多栏显示
    //默认没有头部尾部的微信显示样式
    IFMShareView *shareView = [[IFMShareView alloc] initWithShareItems:arr functionItems:arr2];//默认两栏目，均为一栏显示
    
    shareView.itemSize = CGSizeMake(60, 60); //默认一个值.如果多行排列会取一个合适的值，
    shareView.itemCountEveryRow  //如果多行显示才生效
    shareView.itemImageTopSpace
    shareView.itemImageSize
    
    shareView.itemtitleFont
    shareView.itemtitleColor
    shareView.iconAndTitleSpace
    
    shareView.middleLineSpace //分割线距离边距距离
    
    shareView.headerView = headerView;//设置头视图
    shareView.footerView = footView;//设置尾视图
    
    
    shareView.showsHorizontalScrollIndicator = NO;
    shareView.backView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    
    shareView.cancleButton.frame = CGRectMake(shareView.cancleButton.frame.origin.x, shareView.cancleButton.frame.origin.y, shareView.cancleButton.frame.size.width, 54);
    shareView.cancleButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    
    shareView.showCancleButton = YES;
    
    
    [shareView showInView:self.view];//这个方法里计算尺寸，layoutSubviews内计算
    
}


@end
