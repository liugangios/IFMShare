//
//  IFMShareItemCell.h
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/11.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFMShareItem.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const  kCellIdentifier_IFMShareItemCell;// 循环利用的id

@interface IFMShareItemCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) IFMShareItem *shareItem;

@property (nonatomic) CGSize itemImageSize; //item中image大小
@property (nonatomic) CGFloat itemImageTopSpace; //item图片距离顶部大小
@property (nonatomic) CGFloat iconAndTitleSpace; //item图片和文字距离
@property (nonatomic, assign) BOOL showBorderLine; //是否显示边界线


@end

NS_ASSUME_NONNULL_END
