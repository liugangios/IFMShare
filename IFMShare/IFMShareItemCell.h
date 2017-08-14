//
//  IFMShareItemCell.h
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/11.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFMShareItem.h"

#define kCellIdentifier_IFMShareItemCell @"IFMShareItemCell"

@interface IFMShareItemCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * titleLable;
@property (nonatomic, strong) IFMShareItem *shareItem;

@property (nonatomic) CGSize itemSize; //item大小
@property (nonatomic) NSUInteger itemCountEveryRow; //每一行item个数，多行才有效
@property (nonatomic) CGSize itemImageSize; //item中image大小

@property (nonatomic) CGFloat itemImageTopSpace; //item图片距离顶部大小
@property (nonatomic) CGFloat iconAndTitleSpace; //item图片和文字距离

@property (nonatomic, strong) UIFont *itemtitleFont; //标题字体大小
@property (nonatomic, strong) UIColor *itemtitleColor; //标题字体颜色


@end
