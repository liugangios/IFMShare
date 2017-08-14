//
//  IFMShareItemCell.m
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/11.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "IFMShareItemCell.h"

@implementation IFMShareItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
        
        self.titleLable = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLable];
        
        self.itemSize = CGSizeMake(80, 80);
        self.itemCountEveryRow = 4;
        self.itemImageSize = CGSizeMake(57, 57);
        
        self.itemImageTopSpace = 15;
        self.iconAndTitleSpace = 10;
        
        self.itemtitleFont = [UIFont systemFontOfSize:10];
        self.itemtitleColor = [UIColor blackColor];
    }
    return self;
}

- (void)setShareItem:(IFMShareItem *)shareItem{
    self.shareItem = shareItem;
    self.imageView.image = shareItem.image;
    self.titleLable.text = shareItem.title;
}

- (void)layoutSubviews{
    self.imageView.frame = CGRectMake(0, _itemImageTopSpace,_itemImageSize.width, _itemImageSize.height);
    
    self.titleLable.font = self.itemtitleFont;
    self.titleLable.tintColor = self.itemtitleColor;
    [self.titleLable sizeToFit];
    CGPoint titleCenter = self.imageView.center;
    titleCenter.y += self.imageView.frame.size.height/2 + self.iconAndTitleSpace;
    self.titleLable.center = titleCenter;
}
@end
