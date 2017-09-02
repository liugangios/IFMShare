//
//  IFMShareView.m
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/10.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "IFMShareView.h"


@interface IFMShareView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *shareItems;
@property (nonatomic, strong) NSArray *functionItems;

@property (nonatomic, strong) UIView *containView;//背景View(包裹各种元素的view)
@property (nonatomic, strong) UIView *bodyView;//中间View,主要放分享(去除head、foot放分享按钮的view)
@property (nonatomic, strong) UIView *middleLine;//中间线

@property(nonatomic, weak)UICollectionView *shareCollectionView;
@property(nonatomic, weak)UICollectionView *functionCollectionView;

@property(nonatomic, assign) BOOL oneLine;
@property (nonatomic) NSUInteger itemCountEveryRow; //每一行item个数
@property (nonatomic, weak)UIViewController *presentVC;

@property (nonatomic, strong) NSString *shareText;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) NSURL *shareUrl;
@end

@implementation IFMShareView

#pragma mark - 初始化方法

- (instancetype)initWithFrame:(CGRect)frame {
    
    frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {
        _itemSize = CGSizeMake(80, 80);
        _itemSpace = 0;
        _itemImageSize = CGSizeMake(60, 60);
        _itemImageTopSpace = 15;
        _iconAndTitleSpace = 5;
        _itemTitleColor = [UIColor blackColor];
        _itemTitleFont = [UIFont systemFontOfSize:10];
        _showBorderLine = NO;
        _showsHorizontalScrollIndicator = NO;
        _containViewColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
        _showCancleButton = YES;
        _middleLineColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        _middleTopSpace = 0;
        _middleBottomSpace = 0;
        _middleLineEdgeSpace = 0;
        
        UIControl *maskView = [[UIControl alloc] initWithFrame:frame];
        maskView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
        maskView.tag = 100;
        [maskView addTarget:self action:@selector(maskViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:maskView];
        
        _containView = [[UIView alloc] init];
        _containView.userInteractionEnabled = YES;
        [self addSubview:_containView];
        
        _bodyView = [[UIView alloc] init];
        _bodyView.backgroundColor = [UIColor clearColor];
        _bodyView.userInteractionEnabled = YES;
        [_containView addSubview:_bodyView];
        
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(0, 0, frame.size.width, 50);
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_cancleButton setBackgroundImage:[self imageWithColor:[UIColor whiteColor] size:CGSizeMake(1.0, 1.0)] forState:UIControlStateNormal];
        [_cancleButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0] size:CGSizeMake(1.0, 1.0)] forState:UIControlStateHighlighted];
        [_cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_containView addSubview:_cancleButton];
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)items itemSize:(CGSize)itemSize DisplayLine:(BOOL)oneLine{
    self = [self init];
    if (self) {
        self.shareItems = items;
        self.itemSize = itemSize;
        self.oneLine = oneLine;
    }
    
    return self;
}

- (instancetype)initWithShareItems:(NSArray *)shareItems functionItems:(NSArray *)functionItems itemSize:(CGSize)itemSize{
    self = [self init];
    if (self) {
        self.shareItems = shareItems;
        self.functionItems = functionItems;
        self.itemSize = itemSize;
        self.oneLine = YES;
    }
    return self;
}
- (instancetype)initWithItems:(NSArray *)items countEveryRow:(NSInteger)count{
    self = [self init];
    if (self) {
        self.shareItems = items;
        self.itemSize = CGSizeMake(SCREEN_WIDTH/count, SCREEN_WIDTH/count);
        self.oneLine = NO;
        self.showBorderLine = YES;
        self.showCancleButton = NO;
    }
    return self;
}
#pragma mark - 暴露方法

- (void)showFromControlle:(UIViewController *)controller{
    _presentVC = controller;
    //fix: 自定义导航栏,遮罩不能完全遮住屏幕
    [self showInView:controller.view.window];
    
}

- (void)dismiss:(BOOL)animated{
    if (animated) {
        [self tappedCancel];
    }else{
        [self removeFromSuperview];
    }
}

- (void)addText:(NSString *)text{
    _shareText = text;
}
- (void)addImage:(UIImage *)image{
    _shareImage = image;
}
- (void)addURL:(NSURL *)url{
    _shareUrl = url;
}

#pragma mark - set、get方法

-(void)setHeaderView:(UIView *)headerView {
    [_headerView removeFromSuperview];
    _headerView = headerView;
    [self.containView addSubview:_headerView];
}

-(void)setFooterView:(UIView *)footerView {
    [_footerView removeFromSuperview];
    _footerView = footerView;
    [self.containView addSubview:_footerView];
}

- (UIView *)middleLine {
    if (!_middleLine) {
        _middleLine = [[UIView alloc] init];
        _middleLine.backgroundColor = _middleLineColor;
        [_bodyView addSubview:_middleLine];
    }
    return _middleLine;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    //计算总高度
    float height = _bodyViewEdgeInsets.top + _bodyViewEdgeInsets.bottom;
    
    if (_cancleButton) {
        height += _cancleButton.frame.size.height;
    }
    if (_headerView) {
        height += _headerView.frame.size.height;
    }
    if (_footerView) {
        height += _footerView.frame.size.height;
    }
    if (_middleLine) {
        height += _middleLine.frame.size.height;
    }
    float bodyHeight = 0;
    if (_bodyView) {
        if (_shareCollectionView) {
            bodyHeight += _shareCollectionView.frame.size.height;
        }
        if (_functionCollectionView) {
            bodyHeight += (_shareCollectionView.frame.size.height + 0.5 + + _middleTopSpace + _middleBottomSpace);
        }
        height += bodyHeight;
    }
    
    //动画前置控件位置
    if (_containView) {
        _containView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, height);
    }
    if (_headerView) {
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _headerView.frame.size.height);
    }
    if (_bodyView) {
        float bodyY = _headerView ? CGRectGetMaxY(_headerView.frame) : 0;
        _bodyView.frame = CGRectMake(_bodyViewEdgeInsets.left,bodyY+_bodyViewEdgeInsets.top,SCREEN_WIDTH-_bodyViewEdgeInsets.left-_bodyViewEdgeInsets.right, bodyHeight);
        
        CGRect shareViewSize = _shareCollectionView.frame;
        shareViewSize.size.width = _bodyView.frame.size.width;
        _shareCollectionView.frame = shareViewSize;
        
        CGRect functionViewSize = _functionCollectionView.frame;
        functionViewSize.size.width = _bodyView.frame.size.width;
        _functionCollectionView.frame = functionViewSize;
    }
    if (_footerView) {
        _footerView.frame = CGRectMake(0, CGRectGetMaxY(_bodyView.frame)+_bodyViewEdgeInsets.bottom, SCREEN_WIDTH, _footerView.frame.size.height);
    }
    
    if (_cancleButton) {
        _cancleButton.frame = CGRectMake(0, height-_cancleButton.frame.size.height, SCREEN_WIDTH,_cancleButton.frame.size.height);
    }
    UIView *zhezhaoView = (UIView *)[self viewWithTag:100];
    zhezhaoView.alpha = 0;
    //执行动画
    [UIView animateWithDuration:0.25 animations:^{
        if (_containView) {
            _containView.frame = CGRectMake(0, SCREEN_HEIGHT - height, SCREEN_WIDTH, height);
        }
        
        zhezhaoView.alpha = 0.6;
        
    } completion:nil];
    
}


#pragma mark - Action

- (void)cancleButtonAction:(UIButton *)sender {
    [self tappedCancel];
}

- (void)maskViewClick:(UIControl *)sender {
    [self tappedCancel];
}

- (void)tappedCancel {
    [UIView animateWithDuration:0.25 animations:^{
        UIView *zhezhaoView = (UIView *)[self viewWithTag:100];
        zhezhaoView.alpha = 0;
        
        if (_containView) {
            _containView.frame = CGRectMake(0, SCREEN_HEIGHT,SCREEN_WIDTH, _containView.frame.size.height);
        }
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - 私有方法

- (void)showInView:(UIView *)view{
    _containView.backgroundColor = _containViewColor;
    if (!_showCancleButton) {
        [_cancleButton setTitle:@"" forState:UIControlStateNormal];
        _cancleButton.frame = CGRectZero;
    }
    //计算屏幕容纳几个 cell
    NSInteger count = self.shareItems.count;
    NSInteger numberOfPerRow = SCREEN_WIDTH / _itemSize.width;
    NSInteger number = count / numberOfPerRow;
    NSInteger remainder = count % numberOfPerRow;
    
    CGFloat height = number * _itemSize.height + (remainder > 0 ? _itemSize.height : 0);
    if (_oneLine) {//如果在一行内展示
        height = _itemSize.height;
    }
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    if (_oneLine) {
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    flowLayout.itemSize = _itemSize;
    
    UICollectionView *shareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) collectionViewLayout:flowLayout];
    self.shareCollectionView = shareCollectionView;
    shareCollectionView.delegate = self;
    shareCollectionView.dataSource = self;
    shareCollectionView.showsVerticalScrollIndicator = NO;
    shareCollectionView.showsHorizontalScrollIndicator = _showsHorizontalScrollIndicator;
    shareCollectionView.bounces = _oneLine;
    shareCollectionView.backgroundColor = [UIColor clearColor];
    [shareCollectionView registerClass:[IFMShareItemCell class] forCellWithReuseIdentifier:kCellIdentifier_IFMShareItemCell];
    [self.bodyView addSubview:shareCollectionView];
    
    if (self.functionItems) {
        //分割线
        self.middleLine.frame = CGRectMake(_middleLineEdgeSpace, shareCollectionView.frame.origin.y+shareCollectionView.frame.size.height + _middleTopSpace, self.frame.size.width - 2*_middleLineEdgeSpace, 0.5);
        
        UICollectionViewFlowLayout *functionflowLayout = [[UICollectionViewFlowLayout alloc] init];
        functionflowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        functionflowLayout.itemSize = _itemSize;
        
        UICollectionView *functionCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.middleLine.frame.origin.y+self.middleLine.frame.size.height + _middleBottomSpace, self.frame.size.width, _itemSize.height) collectionViewLayout:functionflowLayout];
        self.functionCollectionView = functionCollectionView;
        functionCollectionView.delegate = self;
        functionCollectionView.dataSource = self;
        functionCollectionView.showsVerticalScrollIndicator = NO;
        functionCollectionView.showsHorizontalScrollIndicator = _showsHorizontalScrollIndicator;
        functionCollectionView.bounces = YES;
        functionCollectionView.backgroundColor = [UIColor clearColor];
        [functionCollectionView registerClass:[IFMShareItemCell class] forCellWithReuseIdentifier:kCellIdentifier_IFMShareItemCell];
        [self.bodyView addSubview:functionCollectionView];
    }
    
    [view addSubview:self];
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

#pragma mark - UICollectionViewDelegate、UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.shareCollectionView) {
        return self.shareItems.count;
    }
    if (collectionView == self.functionCollectionView) {
        return self.functionItems.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    IFMShareItemCell *shareItemCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_IFMShareItemCell forIndexPath:indexPath];
    
    shareItemCell.titleLable.textColor = _itemTitleColor;
    shareItemCell.titleLable.font= _itemTitleFont;
    shareItemCell.itemImageTopSpace = _itemImageTopSpace;
    shareItemCell.iconAndTitleSpace = _iconAndTitleSpace;
    shareItemCell.itemImageSize = _itemImageSize;
    shareItemCell.showBorderLine = _showBorderLine;
    
    if (collectionView == self.shareCollectionView) {
        if ([self.shareItems[indexPath.row] isKindOfClass:[NSString class]]) {
           shareItemCell.shareItem = [[IFMShareItem alloc] initWithPlatformName:self.shareItems[indexPath.row]];
        }else{
           shareItemCell.shareItem = self.shareItems[indexPath.row];
        }
        
    }else{
        if ([self.functionItems[indexPath.row] isKindOfClass:[NSString class]]) {
            shareItemCell.shareItem = [[IFMShareItem alloc] initWithPlatformName:self.functionItems[indexPath.row]];
        }else{
            shareItemCell.shareItem = self.functionItems[indexPath.row];
        }
    }
    shareItemCell.shareItem.shareText = _shareText;
    shareItemCell.shareItem.shareImage = _shareImage;
    shareItemCell.shareItem.shareUrl = _shareUrl;
    shareItemCell.shareItem.presentVC = _presentVC;
    
    return shareItemCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    IFMShareItemCell *cell = (IFMShareItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.shareItem.action) {
        cell.shareItem.action(cell.shareItem);
    }
    [self dismiss:YES];
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (!_oneLine) {
        _itemSpace = 0.0f;
    }
    return _itemSpace;
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}

@end
