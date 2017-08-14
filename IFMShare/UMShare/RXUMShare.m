//
//  RXUMShare.m
//  RXUMDemo2
//
//  Created by srx on 2016/10/25.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXUMShare.h"
#import "Header.h"
#import "Constant.h"
#import "RXShareCell.h"
#import "RXCharacter.h"

#define HideButtonHeight 40
typedef void(^SHARECompletion)(NSString * result);

@interface RXUMShare ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    UIControl * _blackControl;
    UICollectionViewFlowLayout * _flowLayout;
    UICollectionView * _collectionView;
    
    UIButton  * _hideButton;
    
    //-------------------------
    id        _objectController;
    NSArray * _platformArray;
    NSString * _title;
    NSString * _contents;
    NSData   * _imageData;
    
    NSString    * _serverUrl;
    SHARECompletion _shareCompletion;
    
}
@end

@implementation RXUMShare


- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.hidden = YES;
        
        _blackControl = [[UIControl alloc] initWithFrame:CGRectZero];
        _blackControl.backgroundColor = [UIColor blackColor];
        _blackControl.alpha = 0.4;
        [_blackControl addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(CELL_ROW_WIDTH, CELL_ROW_HEIGHT);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[RXShareCell class] forCellWithReuseIdentifier:@"platformCell"];
        [self addSubview:_collectionView];
        
        
        _hideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _hideButton.frame = CGRectMake(0, 0, ScreenWidth, HideButtonHeight);
        [_hideButton setTitle:@"取消" forState:UIControlStateNormal];
        [_hideButton setTitleColor:GHS_333_COLOR forState:UIControlStateNormal];
        _hideButton.backgroundColor = [UIColor lightGrayColor];
        [_hideButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_hideButton];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _platformArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifer = @"platformCell";
    RXShareCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer forIndexPath:indexPath];
    [cell setCellPlatform:_platformArray[indexPath.row]];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)shareInController:(id)controller platforms:(NSArray<NSString *> *)platforms title:(NSString *)title contents:(NSString *)contents imageURLString:(NSString *)imageURLString completion:(void (^)(NSString *))completion {
    _objectController = controller;
    if(![platforms arrBOOL]) {
        completion(@"平台参数设置错误");
        return;
    }
    _platformArray = platforms;
    
    //collection frame
    NSInteger count = platforms.count;

    //屏幕容纳 几个 cell
    NSInteger divisor = ScreenWidth / CELL_ROW_HEIGHT;
    //除数
    NSInteger number = count / divisor;
    //余数
    NSInteger remainder = count % divisor;
    CGFloat height = number * CELL_ROW_HEIGHT + (remainder > 0 ? CELL_ROW_HEIGHT : 0);
 
    _collectionView.frame = CGRectMake(0, 0, ScreenWidth, height);
    [_collectionView reloadData];
    _hideButton.frame = CGRectMake(0, height, ScreenWidth, HideButtonHeight);
    
    
    _title = title;
    _contents = contents;
    _imageData = [self dateContent:imageURLString];
    
    [self.superview bringSubviewToFront:self];
    _blackControl.frame = self.superview.bounds;
    [self.superview insertSubview:_blackControl belowSubview:self];
    
    self.hidden = NO;
    
    CGFloat top = ScreenHeight - height - HideButtonHeight;
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, top, ScreenWidth, height +HideButtonHeight);
    } completion:^(BOOL finished) {
        //后端让自己拼 该分享 要 跳转 的url
        NSString * shareSeverUrl = [SERVER_URL stringByReplacingOccurrencesOfString:@"api" withString:@""];
         _serverUrl= [NSString stringWithFormat:@"%@/wap/productshare.html", shareSeverUrl];
    }];
    
    _shareCompletion = completion;
    
}

- (NSData *)dateContent:(NSString *)string {
    if(![string strBOOL]) {
        return nil;
    }
    // 图片压缩
    if([string urlBOOL]) {
        return UIImageJPEGRepresentation([UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:string]]], 0.1);
    }
    else {
        NSData * data =  UIImagePNGRepresentation([UIImage imageNamed:string]);
        if(data.length > 0) {
            return [NSData data];
        }
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:string])
        {
            return  UIImageJPEGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfFile:string]], 0.1);
        }
        else {
            NSLog(@"分享的图片地址 不存在");
        }
        return nil;
    }
}

- (void)hide {
    [_blackControl removeFromSuperview];

    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        
    }];
}
@end
