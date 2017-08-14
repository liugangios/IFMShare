//
//  IFMShareView.m
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/10.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "IFMShareView.h"
#import "IFMShareItemCell.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface IFMShareView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, weak)UICollectionView *shareCollectionView;
@property(nonatomic, weak)UICollectionView *functionCollectionView;
@end

@implementation IFMShareView
- (instancetype)initWithFrame:(CGRect)frame {
    
    frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {
        // #TODO:换成UIControl
        UIControl *maskView = [[UIControl alloc] initWithFrame:frame];
        maskView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
        maskView.tag = 100;
        [maskView addTarget:self action:@selector(maskViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:maskView];
        
        
        _containView = [[UIView alloc] init];
        _containView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
        _containView.userInteractionEnabled = YES;
        [self addSubview:_containView];
        
        _bodyView = [[UIView alloc] init];
        _bodyView.backgroundColor = [UIColor clearColor];
        _bodyView.userInteractionEnabled = YES;
        [self addSubview:_bodyView];
        
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(0, 0, frame.size.width, 50);
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_cancleButton setBackgroundImage:[self imageWithColor:[UIColor whiteColor] size:CGSizeMake(1.0, 1.0)] forState:UIControlStateNormal];
        [_cancleButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0] size:CGSizeMake(1.0, 1.0)] forState:UIControlStateHighlighted];
        [_cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancleButton];
    }
    return self;
}
-(void)setHeaderView:(UIView *)headerView {
    [_headerView removeFromSuperview];
    _headerView = headerView;
    [self addSubview:_headerView];
}

-(void)setFooterView:(UIView *)footerView {
    [_footerView removeFromSuperview];
    _footerView = footerView;
    [self addSubview:_footerView];
}
- (UIView *)middleLine {
    if (!_middleLine) {
        _middleLine = [[UIView alloc] init];
        _middleLine.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
        [_bodyView addSubview:_middleLine];
    }
    return _middleLine;
}


- (instancetype)initWithItems:(NSArray *)items DisplayLine:(BOOL)inLine{
    self.shareItems = items;
    
     //计算屏幕容纳几个 cell
    NSInteger count = self.shareItems.count;
    NSInteger numberOfPerRow = SCREEN_WIDTH / 80.0;
    NSInteger number = count / numberOfPerRow;
    NSInteger remainder = count % numberOfPerRow;
    
    CGFloat height = number * 80 + (remainder > 0 ? 80 : 0);
    if (inLine) {//如果在一行内展示
        height = 80;
    }
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) collectionViewLayout:flowLayout];
    self.shareCollectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[IFMShareItemCell class] forCellWithReuseIdentifier:kCellIdentifier_IFMShareItemCell];
    [self.bodyView addSubview:collectionView];
    
    return self;
}
- (instancetype)initWithShareItems:(NSArray *)shareItems functionItems:(NSArray *)functionItems{
    self.shareItems = shareItems;
    self.functionItems = functionItems;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    UICollectionView *shareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) collectionViewLayout:flowLayout];
    self.shareCollectionView = shareCollectionView;
    shareCollectionView.delegate = self;
    shareCollectionView.dataSource = self;
    shareCollectionView.showsVerticalScrollIndicator = NO;
    shareCollectionView.showsHorizontalScrollIndicator = NO;
    shareCollectionView.bounces = NO;
    shareCollectionView.backgroundColor = [UIColor whiteColor];
    [shareCollectionView registerClass:[IFMShareItemCell class] forCellWithReuseIdentifier:kCellIdentifier_IFMShareItemCell];
    [_bodyView addSubview:shareCollectionView];
    
    if (!self.functionItems) {
        //分割线
        self.middleLine.frame = CGRectMake(0, shareCollectionView.frame.origin.y+shareCollectionView.frame.size.height, self.frame.size.width, 0.5);
        //shareScrollView2   功能性Item，#TODO:应该换一个名字
        UICollectionView *functionCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.middleLine.frame.origin.y+self.middleLine.frame.size.height, self.frame.size.width, 80) collectionViewLayout:flowLayout];
        self.functionCollectionView = functionCollectionView;
        shareCollectionView.delegate = self;
        shareCollectionView.dataSource = self;
        shareCollectionView.showsVerticalScrollIndicator = NO;
        shareCollectionView.showsHorizontalScrollIndicator = NO;
        shareCollectionView.bounces = NO;
        shareCollectionView.backgroundColor = [UIColor whiteColor];
        [shareCollectionView registerClass:[IFMShareItemCell class] forCellWithReuseIdentifier:kCellIdentifier_IFMShareItemCell];
   
        [_bodyView addSubview:functionCollectionView];
    }
    return self;
}
- (void)cancleButtonAction:(UIButton *)sender {
    [self tappedCancel];
}

- (void)maskViewClick:(UIControl *)sender {
    [self tappedCancel];
}

- (void)tappedCancel {
    [UIView animateWithDuration:0.5 animations:^{
        UIView *zhezhaoView = (UIView *)[self viewWithTag:100];
        zhezhaoView.alpha = 0;
        
        if (_containView) {
            _containView.frame = CGRectMake(0, self.frame.size.height, _containView.frame.size.width, _containView.frame.size.height);
        }
        
        if (_cancleButton) {
            _cancleButton.frame = CGRectMake(0, _cancleButton.frame.origin.y + _containView.frame.size.height, _cancleButton.frame.size.width, _cancleButton.frame.size.height);
        }
        
        if (_footerView) {
            _footerView.frame = CGRectMake(0, _footerView.frame.origin.y + _containView.frame.size.height, _footerView.frame.size.width, _footerView.frame.size.height);
        }
        
        if (_bodyView) {
            _bodyView.frame = CGRectMake(0, _bodyView.frame.origin.y + _containView.frame.size.height, _bodyView.frame.size.width, _bodyView.frame.size.height);
        }
        
        if (_headerView) {
            _headerView.frame = CGRectMake(0, _headerView.frame.origin.y + _containView.frame.size.height, _headerView.frame.size.width, _headerView.frame.size.height);
        }
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    float height = 0;
    
    if (_cancleButton) {
        height += _cancleButton.frame.size.height;
        _cancleButton.frame = CGRectMake(0, self.frame.size.height-height, _cancleButton.frame.size.width, _cancleButton.frame.size.height);
        _cancleButton.hidden = YES;
    }
    
    if (_footerView) {
        height += _footerView.frame.size.height;
        _footerView.frame = CGRectMake(0, self.frame.size.height-height, _footerView.frame.size.width, _footerView.frame.size.height);
        _footerView.hidden = YES;
    }
    
    if (_bodyView) {
        height += _bodyView.frame.size.height;
        _bodyView.frame = CGRectMake(0, self.frame.size.height-height, _bodyView.frame.size.width, _bodyView.frame.size.height);
        _bodyView.hidden = YES;
    }
    
    if (_headerView) {
        height += _headerView.frame.size.height;
        _headerView.frame = CGRectMake(0, self.frame.size.height-height, _headerView.frame.size.width, _headerView.frame.size.height);
        _headerView.hidden = YES;
    }
    
    if (_containView) {
        _containView.frame = CGRectMake(0, self.frame.size.height-height, _containView.frame.size.width, height);
        _containView.hidden = YES;
    }
    
    if (_cancleButton) {
        _cancleButton.frame = CGRectMake(0, _cancleButton.frame.origin.y + _containView.frame.size.height, _cancleButton.frame.size.width, _cancleButton.frame.size.height);
        _cancleButton.hidden = NO;
    }
    
    if (_footerView) {
        _footerView.frame = CGRectMake(0, _footerView.frame.origin.y + _containView.frame.size.height, _footerView.frame.size.width, _footerView.frame.size.height);
        _footerView.hidden = NO;
    }
    
    if (_bodyView) {
        _bodyView.frame = CGRectMake(0, _bodyView.frame.origin.y + _bodyView.frame.size.height, _bodyView.frame.size.width, _bodyView.frame.size.height);
        _bodyView.hidden = NO;
    }
    
    if (_headerView) {
        _headerView.frame = CGRectMake(0, _headerView.frame.origin.y + _containView.frame.size.height, _headerView.frame.size.width, _headerView.frame.size.height);
        _headerView.hidden = NO;
    }
    
    if (_containView) {
        _containView.frame = CGRectMake(0, self.frame.size.height, _containView.frame.size.width, _containView.frame.size.height);
        _containView.hidden = NO;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if (_cancleButton) {
            _cancleButton.frame = CGRectMake(0, _cancleButton.frame.origin.y - _containView.frame.size.height, _cancleButton.frame.size.width, _cancleButton.frame.size.height);
        }
        
        if (_footerView) {
            _footerView.frame = CGRectMake(0, _footerView.frame.origin.y - _containView.frame.size.height, _footerView.frame.size.width, _footerView.frame.size.height);
        }
        
        if (_bodyView) {
            _bodyView.frame = CGRectMake(0, _bodyView.frame.origin.y - _bodyView.frame.size.height, _bodyView.frame.size.width, _bodyView.frame.size.height);
        }
        
        if (_headerView) {
            _headerView.frame = CGRectMake(0, _headerView.frame.origin.y - _containView.frame.size.height, _headerView.frame.size.width, _headerView.frame.size.height);
        }
        
        if (_containView) {
            _containView.frame = CGRectMake(0, self.frame.size.height - _containView.frame.size.height, _containView.frame.size.width, _containView.frame.size.height);
        }
        
        UIView *zhezhaoView = (UIView *)[self viewWithTag:100];
        zhezhaoView.alpha = 0.9;
        
    } completion:^(BOOL finished) {
        
    }];
}


- (void)showInView:(UIView *)view{
    [view addSubview:self];
}

#pragma mark UICollectionViewDelegate、UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.shareCollectionView) {
        return self.shareItems.count;
    }
    return self.functionItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    IFMShareItemCell *shareItemCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_IFMShareItemCell forIndexPath:indexPath];
    if (collectionView == self.shareCollectionView) {
        shareItemCell.shareItem = self.shareItems[indexPath.row];
    }else{
        shareItemCell.shareItem = self.functionItems[indexPath.row];
    }
    return shareItemCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    IFMShareItem *shareItem;
    if (collectionView == self.shareCollectionView) {
        shareItem = self.shareItems[indexPath.row];
    }else{
        shareItem = self.functionItems[indexPath.row];
    }
    
    if (shareItem.action) {
        shareItem.action(shareItem);
    }
   
}


//颜色生成图片方法
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
@end
