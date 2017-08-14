//
//  IFMShareItem.h
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/10.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//预制的分享平台
extern NSString *const  IFMPlatformNameSina;// 新浪微博
extern NSString *const  IFMPlatformNameQQ;//QQ
extern NSString *const  IFMPlatformNameEmail;//邮箱
extern NSString *const  IFMPlatformNameSms;//短信
extern NSString *const  IFMPlatformNameWechat;//微信
extern NSString *const  IFMPlatformNameAlipay;//支付宝

//预制的分享点击事件
extern NSString *const  IFMPlatformHandleSina;// 新浪微博
extern NSString *const  IFMPlatformHandleQQ;//QQ
extern NSString *const  IFMPlatformHandleEmail;//邮箱
extern NSString *const  IFMPlatformHandleSms;//短信
extern NSString *const  IFMPlatformHandleWechat;//微信
extern NSString *const  IFMPlatformHandleAlipay;//支付宝


@interface IFMShareItem : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) void (^action)(IFMShareItem *item);

- (void)clickItem;
+ (instancetype)itemWithImage:(UIImage *)image
                        title:(NSString *)title
                       action:(void (^)(IFMShareItem *item))action;
@end
