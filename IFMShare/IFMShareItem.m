//
//  IFMShareItem.m
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/10.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "IFMShareItem.h"

@implementation IFMShareItem
+ (instancetype)itemWithImage:(UIImage *)image
                        title:(NSString *)title
                       action:(void (^)(IFMShareItem *item))action;
{
    return [[IFMShareItem alloc] init:title
                               image:image
                              action:(void (^)(IFMShareItem *item))action];
}
- (instancetype) init:(NSString *) title
                image:(UIImage *) image
               action:(void (^)(IFMShareItem *item))action
{
    NSParameterAssert(title.length || image);
    
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _action = action;
    }
    return self;
}

- (void)clickItem
{
    if (self.action) {
        self.action(self);
    }
}
@end
