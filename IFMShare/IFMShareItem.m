//
//  IFMShareItem.m
//  IFMShareDemo
//
//  Created by 刘刚 on 2017/8/10.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "IFMShareItem.h"
#import <Social/Social.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

NSString *const  IFMPlatformNameSina = @"IFMPlatformNameSina";
NSString *const  IFMPlatformNameQQ = @"IFMPlatformNameQQ";
NSString *const  IFMPlatformNameEmail = @"IFMPlatformNameEmail";
NSString *const  IFMPlatformNameSms = @"IFMPlatformNameSms";
NSString *const  IFMPlatformNameWechat = @"IFMPlatformNameWechat";
NSString *const  IFMPlatformNameAlipay = @"IFMPlatformNameAlipay";
//NSString *const  IFMPlatformNameTwitter = @"IFMPlatformNameTwitter";
//NSString *const  IFMPlatformNameFacebook = @"IFMPlatformNameFacebook";
//NSString *const  IFMPlatformNameInstagram = @"IFMPlatformNameInstagram";
//NSString *const  IFMPlatformNameNotes = @"IFMPlatformNameNotes";
//NSString *const  IFMPlatformNameReminders = @"IFMPlatformNameReminders";
//NSString *const  IFMPlatformNameiCloud = @"IFMPlatformNameiCloud";


NSString *const  IFMPlatformHandleSina = @"IFMPlatformHandleSina";
NSString *const  IFMPlatformHandleQQ = @"IFMPlatformHandleQQ";
NSString *const  IFMPlatformHandleEmail = @"IFMPlatformHandleEmail";
NSString *const  IFMPlatformHandleSms = @"IFMPlatformHandleSms";
NSString *const  IFMPlatformHandleWechat = @"IFMPlatformHandleWechat";
NSString *const  IFMPlatformHandleAlipay = @"IFMPlatformHandleAlipay";
NSString *const  IFMPlatformHandleTwitter = @"IFMPlatformHandleTwitter";
NSString *const  IFMPlatformHandleFacebook = @"IFMPlatformHandleFacebook";
NSString *const  IFMPlatformHandleInstagram = @"IFMPlatformHandleInstagram";
NSString *const  IFMPlatformHandleNotes = @"IFMPlatformHandleNotes";
NSString *const  IFMPlatformHandleReminders = @"IFMPlatformHandleReminders";
NSString *const  IFMPlatformHandleiCloud = @"IFMPlatformHandleiCloud";

@interface IFMShareItem()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@end

@implementation IFMShareItem

#pragma mark - 初始化方法

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                       action:(shareHandle)action
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

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                   actionName:(NSString *)actionName
{
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _action = [self actionFromString:actionName];
    }
    return self;
}

- (instancetype)initWithPlatformName:(NSString *)platformName{
    
/******************************各种平台***********************************************/
    NSDictionary *messageDict;
    if ([platformName isEqualToString:IFMPlatformNameSina]) {
        messageDict = @{@"image":@"share_sina",@"title":@"新浪微博",@"action":IFMPlatformHandleSina};
    }
    if ([platformName isEqualToString:IFMPlatformNameQQ]) {
        messageDict = @{@"image":@"share_qq",@"title":@"QQ",@"action":IFMPlatformHandleQQ};
    }
    if ([platformName isEqualToString:IFMPlatformNameEmail]) {
        messageDict = @{@"image":@"share_email",@"title":@"邮件",@"action":IFMPlatformHandleEmail};
    }
    if ([platformName isEqualToString:IFMPlatformNameSms]) {
        messageDict = @{@"image":@"share_sms",@"title":@"短信",@"action":IFMPlatformHandleSms};
    }
    if ([platformName isEqualToString:IFMPlatformNameWechat]) {
        messageDict = @{@"image":@"share_weixin",@"title":@"微信",@"action":IFMPlatformHandleWechat};
    }
    if ([platformName isEqualToString:IFMPlatformNameAlipay]) {
        messageDict = @{@"image":@"share_alipay",@"title":@"支付宝",@"action":IFMPlatformHandleAlipay};
    }
    
/*********************************end************************************************/
    
    self = [super init];
    if (self) {
        _title = (messageDict[@"title"] ? messageDict[@"title"] : @"");
        _image = [UIImage imageNamed:[@"IFMShareImage.bundle" stringByAppendingPathComponent:messageDict[@"image"]]];
        _action = [self actionFromString:messageDict[@"action"]];
    }
    return self;
}

#pragma mark - 私有方法

//字符串转 Block
- (shareHandle)actionFromString:(NSString *)handleName{
    
    __weak typeof(self) weakSelf = self;
    shareHandle handle = ^(IFMShareItem *item){
        NSString *tipPlatform;
        if ([handleName isEqualToString:IFMPlatformHandleEmail]) {
            [weakSelf sendmailTO:@""];
            return ;
        }
        if ([handleName isEqualToString:IFMPlatformHandleSms]) {
            [weakSelf sendMessageTO:@""];
            return ;
        }
/******************************各种平台***********************************************/
        NSString *platformID;
        if ([handleName isEqualToString:IFMPlatformHandleSina]) {
            platformID = @"com.apple.share.SinaWeibo.post";
            tipPlatform = @"新浪微博";
        }
        if ([handleName isEqualToString:IFMPlatformHandleQQ]) {
            platformID = @"com.tencent.mqq.ShareExtension";
            tipPlatform = @"QQ";
        }
        if ([handleName isEqualToString:IFMPlatformHandleWechat]) {
            platformID = @"com.tencent.xin.sharetimeline";
            tipPlatform = @"微信";
        }
        if ([handleName isEqualToString:IFMPlatformHandleAlipay]) {
            platformID = @"com.alipay.iphoneclient.ExtensionSchemeShare";
            tipPlatform = @"支付宝";
        }
        if ([handleName isEqualToString:IFMPlatformHandleTwitter]) {
            platformID = @"com.apple.share.Twitter.post";
            tipPlatform = @"推特";
        }
        if ([handleName isEqualToString:IFMPlatformHandleFacebook]) {
            platformID = @"com.apple.share.Facebook.post";
            tipPlatform = @"脸书";
        }
        if ([handleName isEqualToString:IFMPlatformHandleInstagram]) {
            platformID = @"com.burbn.instagram.shareextension";
            tipPlatform = @"instagram";
        }
        if ([handleName isEqualToString:IFMPlatformHandleNotes]) {
            platformID = @"com.apple.mobilenotes.SharingExtension";
            tipPlatform = @"备忘录";
        }
        if ([handleName isEqualToString:IFMPlatformHandleReminders]) {
            platformID = @"com.apple.reminders.RemindersEditorExtension";
            tipPlatform = @"提醒事项";
        }
        if ([handleName isEqualToString:IFMPlatformHandleiCloud]) {
            platformID = @"com.apple.mobileslideshow.StreamShareService";
            tipPlatform = @"iCloud";
        }
        
/********************************end*************************************************/
        
        NSString *UNLoginTip = [NSString stringWithFormat:@"没有配置%@相关的帐号",tipPlatform];
        NSString *UNInstallTip = [NSString stringWithFormat:@"没有安装%@",tipPlatform];
       
        SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:platformID];
        if (composeVc == nil){
            ALERT_MSG(@"提示",UNInstallTip,weakSelf.presentVC);
            return;
        }
        if (![SLComposeViewController isAvailableForServiceType:platformID]) {
            ALERT_MSG(@"提示",UNLoginTip,weakSelf.presentVC);
            return;
        }
        if (weakSelf.shareText) [composeVc setInitialText:weakSelf.shareText];
        if (weakSelf.shareImage) [composeVc addImage:weakSelf.shareImage];
        if (weakSelf.shareUrl) [composeVc addURL:weakSelf.shareUrl];
        
        [weakSelf.presentVC presentViewController:composeVc animated:YES completion:nil];
        composeVc.completionHandler = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"点击了取消");
            } else {
                NSLog(@"点击了发送");
            }
        };
        
    };
    return handle;
}

- (void)sendmailTO:(NSString *)email
{
    if (![MFMailComposeViewController canSendMail]) {
        ALERT_MSG(@"提示",@"手机未设置邮箱",_presentVC);
        return;
    }

    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    [controller setToRecipients:@[email]];
    if (_shareText) {
        [controller setSubject:_shareText];
    }
    if (_shareUrl) {
        [controller setMessageBody:[NSString stringWithFormat:@"%@",_shareUrl] isHTML:YES];
    }
    if (_shareImage) {
        NSData *imageData = UIImagePNGRepresentation(_shareImage);
        [controller addAttachmentData:imageData mimeType:@"image/png" fileName:@"图片.png"];
    }
    
    [controller setMailComposeDelegate:self];

    [_presentVC presentViewController:controller animated:YES completion:nil];
}
- (void)sendMessageTO:(NSString *)phoneNum{
    
    if(![MFMessageComposeViewController canSendText] ){
        ALERT_MSG(@"提示",@"设备不能发短信",_presentVC);
        return;
    }
   
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    [controller setRecipients:@[phoneNum]];
    NSString *bodySting = @"";
    if (_shareText) [bodySting stringByAppendingString:_shareText];
    if (_shareUrl) [bodySting stringByAppendingString:[NSString stringWithFormat:@"%@",_shareUrl]];
    controller.messageComposeDelegate =self;
    
    [_presentVC presentViewController:controller animated:YES completion:nil];;
    
}

#pragma mark - 邮件、短息代理方法

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [_presentVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [_presentVC dismissViewControllerAnimated:YES completion:nil];
}

@end
