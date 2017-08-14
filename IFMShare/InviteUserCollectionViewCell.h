//
//  InviteUserCollectionViewCell.h
//  YonyouIM
//
//  Created by litfb on 15/5/13.
//  Copyright (c) 2015年 yonyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InviteUserCollectionViewCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UIImageView *headImage;

@property (nonatomic) CGFloat roundCorner;

- (void)setHeadImageWithUrl:(NSString *)headUrl;

- (void)setHeadImageWithUrl:(NSString *)headUrl placeholderName:(NSString *)name;

@end
