//
//  IFMShareItem.h
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/10.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define  ALERT_MSG(TITLE,MESSAGE,CONTROLLER) UIAlertController *alertController = [UIAlertController alertControllerWithTitle:TITLE message:MESSAGE preferredStyle:UIAlertControllerStyleAlert];\
[alertController addAction:[UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:nil]];\
[CONTROLLER presentViewController:alertController animated:YES completion:nil];

#define  IFMColor(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@class IFMShareItem;
typedef void (^__nullable shareHandle)(IFMShareItem *item);

//预制的分享平台
extern NSString *const  IFMPlatformNameSina;// 新浪微博
extern NSString *const  IFMPlatformNameQQ;//QQ
extern NSString *const  IFMPlatformNameEmail;//邮箱
extern NSString *const  IFMPlatformNameSms;//短信
extern NSString *const  IFMPlatformNameWechat;//微信
extern NSString *const  IFMPlatformNameAlipay;//支付宝

/******************************没有图片、待补充***********************************************/
//extern NSString *const  IFMPlatformNameTwitter;//推特
//extern NSString *const  IFMPlatformNameFacebook;//脸书
//extern NSString *const  IFMPlatformNameInstagram;//instagram
//extern NSString *const  IFMPlatformNameNotes;//备忘录
//extern NSString *const  IFMPlatformNameReminders;//提醒事项
//extern NSString *const  IFMPlatformNameiCloud;//iCloud


//预制的分享事件
extern NSString *const  IFMPlatformHandleSina;// 新浪微博
extern NSString *const  IFMPlatformHandleQQ;//QQ
extern NSString *const  IFMPlatformHandleEmail;//邮箱
extern NSString *const  IFMPlatformHandleSms;//短信
extern NSString *const  IFMPlatformHandleWechat;//微信
extern NSString *const  IFMPlatformHandleAlipay;//支付宝
extern NSString *const  IFMPlatformHandleTwitter;//推特
extern NSString *const  IFMPlatformHandleFacebook;//脸书
extern NSString *const  IFMPlatformHandleInstagram;//instagram
extern NSString *const  IFMPlatformHandleNotes;//备忘录
extern NSString *const  IFMPlatformHandleReminders;//提醒事项
extern NSString *const  IFMPlatformHandleiCloud;//iCloud


@interface IFMShareItem : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak)UIViewController *presentVC;
@property (nonatomic, copy) shareHandle action;

@property (nullable, nonatomic, strong) NSString *shareText;
@property (nullable, nonatomic, strong) UIImage *shareImage;
@property (nullable, nonatomic, strong) NSURL *shareUrl;

/*
 * 调用以下代码获取手机中装的App的所有Share Extension的ServiceType
 
 SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
 
 * 我获得的部分数据
 
 com.taobao.taobao4iphone.ShareExtension  淘宝
 com.apple.share.Twitter.post  推特
 com.apple.share.Facebook.post 脸书
 com.apple.share.SinaWeibo.post 新浪微博
 com.apple.share.Flickr.post 雅虎
 com.burbn.instagram.shareextension   instagram
 com.amazon.AmazonCN.AWListShareExtension 亚马逊
 com.apple.share.TencentWeibo.post 腾讯微博
 com.smartisan.notes.SMShare 锤子便签
 com.zhihu.ios.Share 知乎
 com.tencent.mqq.ShareExtension QQ
 com.tencent.xin.sharetimeline 微信
 com.alipay.iphoneclient.ExtensionSchemeShare 支付宝
 com.apple.mobilenotes.SharingExtension  备忘录
 com.apple.reminders.RemindersEditorExtension 提醒事项
 com.apple.Health.HealthShareExtension      健康
 com.apple.mobileslideshow.StreamShareService  iCloud
 
 */


- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                       action:(shareHandle)action;

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                   actionName:(NSString *)actionName;

- (instancetype)initWithPlatformName:(NSString *)platformName;


@end

NS_ASSUME_NONNULL_END
