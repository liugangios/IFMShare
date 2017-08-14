//
//  RXShareCell.h
//  RXUMDemo2
//
//  Created by srx on 2016/10/25.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_ROW_WIDTH 80
#define CELL_ROW_HEIGHT 80

@interface RXShareCell : UICollectionViewCell
@property (nonatomic, copy, readonly) UIImageView * imgView;
@property (nonatomic, copy, readonly) UILabel * platformLabel;

- (void)setCellPlatform:(NSString *)platform;
@end
