//
//  HXShareScrollView.m
//  IT小子
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.

#import "HXShareScrollView.h"
#import "HXEasyCustomShareView.h"

@implementation HXShareScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = YES;
        self.backgroundColor = [UIColor clearColor];
        
        _originX = HXOriginX;
        _originY = HXOriginY;
        _icoWidth = HXIcoWidth;
        _icoAndTitleSpace = HXIcoAndTitleSpace;
        _titleSize = HXTitleSize;
        _titleColor = HXTitleColor;
        _lastlySpace = HXLastlySpace;
        _horizontalSpace = HXHorizontalSpace;

        //设置当前scrollView的高度
        if (self.frame.size.height <= 0) {//#TODO:换成屏幕的宽度
            self.frame = CGRectMake(CGRectGetMinX([self frame]), CGRectGetMinY([self frame]), CGRectGetWidth([self frame]), _originY+_icoWidth+_icoAndTitleSpace+_titleSize+_lastlySpace);
        } else {
            self.frame = frame;
        }
    }
    return self;
}

- (void)setShareAry:(NSArray *)shareAry delegate:(id)delegate {
    
    //先移除之前的View
    if (self.subviews.count > 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    //代理
    _myDelegate = delegate;

    //设置当前scrollView的contentSize
    if (shareAry.count > 0) {
        //单行
        self.contentSize = CGSizeMake(_originX+shareAry.count*(_icoWidth+_horizontalSpace),self.frame.size.height);
    }
    
    //遍历标签数组,将标签显示在界面上,并给每个标签打上tag加以区分
    for (NSDictionary *shareDic in shareAry) {
        
        NSUInteger i = [shareAry indexOfObject:shareDic];
        
        CGRect frame = CGRectMake(_originX+i*(_icoWidth+_horizontalSpace), _originY, _icoWidth, _icoWidth+_icoAndTitleSpace+_titleSize);;
        UIView *view = [self ittemShareViewWithFrame:frame dic:shareDic];
        [self addSubview:view];
    }
}

- (UIView *)ittemShareViewWithFrame:(CGRect)frame dic:(NSDictionary *)dic {

    NSString *image = dic[@"image"];
    NSString *highlightedImage = dic[@"highlightedImage"];
    NSString *title = [dic[@"title"] length] > 0 ? dic[@"title"] : @"";
    
    UIImage *icoImage = [UIImage imageNamed:image];
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((view.frame.size.width-icoImage.size.width)/2, 0, icoImage.size.width, icoImage.size.height);
    button.titleLabel.font = [UIFont systemFontOfSize:_titleSize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    if (image.length > 0) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highlightedImage.length > 0) {
        [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    }
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, button.frame.origin.y +button.frame.size.height+ _lastlySpace, view.frame.size.width, _titleSize)];
    label.textColor = _titleColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:_titleSize];
    label.text = title;
    [view addSubview:label];
    
    return view;
}

+ (float)getShareScrollViewHeight {
    float height = HXOriginY+HXIcoWidth+HXIcoAndTitleSpace+HXTitleSize+HXLastlySpace;
    return height;
}

- (void)buttonAction:(UIButton *)sender {
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(shareScrollViewButtonAction:title:)]) {
        [_myDelegate shareScrollViewButtonAction:self title:sender.titleLabel.text];
    }
}

@end
