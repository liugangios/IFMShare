//
//  InviteUserCollectionViewCell.m
//  YonyouIM
//
//  Created by litfb on 15/5/13.
//  Copyright (c) 2015年 yonyou. All rights reserved.
//

#import "InviteUserCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+YYIMCategory.h"

@implementation InviteUserCollectionViewCell

- (void)awakeFromNib {
    
}

- (void)prepareForReuse {
    self.headImage.image = nil;
    self.roundCorner = 0.0f;
}

- (void)setRoundCorner:(CGFloat)roundCorner {
    _roundCorner = roundCorner;
    CALayer *layer = [self.headImage layer];
    if (_roundCorner > 0) {
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:_roundCorner];
    } else {
        [layer setMasksToBounds:NO];
        [layer setCornerRadius:0];
    }
}

- (void) setHeadImageWithUrl:(NSString *) headUrl {
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:headUrl]
                      placeholderImage:[UIImage imageNamed:@"icon_head"] options:0];
}

- (void)setHeadImageWithUrl:(NSString *)headUrl placeholderName:(NSString *)name {
    UIImage *image = [UIImage imageWithDispName:name];
    if (!image) {
        image = [UIImage imageNamed:@"icon_head"];
    }
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:headUrl]
                      placeholderImage:image options:0];
}

@end
