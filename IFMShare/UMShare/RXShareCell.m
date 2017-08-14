//
//  RXShareCell.m
//  RXUMDemo2
//
//  Created by srx on 2016/10/25.
//  Copyright © 2016年 https{//github.com/srxboys. All rights reserved.
//

#import "RXShareCell.h"

#define CELL_LABEL_FONTSIZE 12
#define CELL_IMG_WH CELL_ROW_WIDTH - 20 - CELL_LABEL_FONTSIZE

@implementation RXShareCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.backgroundColor = [UIColor redColor];
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((20 + CELL_LABEL_FONTSIZE)/2, 5, CELL_IMG_WH, CELL_IMG_WH)];
//        _imgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imgView];
        
        _platformLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CELL_IMG_WH + 5, CELL_ROW_WIDTH, CELL_LABEL_FONTSIZE + 5)];
        _platformLabel.font = [UIFont systemFontOfSize:CELL_LABEL_FONTSIZE - 1];
//        _platformLabel.backgroundColor = [UIColor redColor];
        _platformLabel.textColor = [UIColor blackColor];
        _platformLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_platformLabel];
    }
    return self;
}

- (void)setCellPlatform:(NSString *)platform {
    NSString * imageName = nil;
    NSString * platformName = nil;
    if(platform == UMSPlatformNameSina) {
        imageName = @"UMS_sina_icon";
        platformName = UMLocalizedString(@"sina",@"新浪微博");
    }
    else if(platform == UMSPlatformNameWechatSession) {
        imageName = @"UMS_wechat_session_icon";
        platformName = UMLocalizedString(@"wechat",@"微信");
    }
    else if(platform == UMSPlatformNameWechatTimeline) {
        imageName = @"UMS_wechat_timeline_icon";
        platformName = UMLocalizedString(@"wechat_timeline",@"微信朋友圈");
    }
    else if(platform == UMSPlatformNameWechatFavorite) {
        imageName = @"UMS_wechat_favorite_icon";
        platformName = UMLocalizedString(@"wechat_favorite",@"微信收藏");
    }
    else if(platform == UMSPlatformNameQQ) {
        imageName = @"UMS_qq_icon";
        platformName = UMLocalizedString(@"qq",@"QQ");
    }
    else if(platform == UMSPlatformNameQzone) {
        imageName = @"UMS_qzone_icon";
        platformName = UMLocalizedString(@"qzone",@"QQ空间");
    }
    else if(platform == UMSPlatformNameTencentWb) {
        imageName = @"UMS_tencent_icon";
        platformName = UMLocalizedString(@"tencentWB",@"腾讯微博");
    }
    else if(platform == UMSPlatformNameAlipaySession) {
        imageName = @"UMS_alipay_session_icon";
        platformName = UMLocalizedString(@"alipay",@"支付宝");
    }
    else if(platform == UMSPlatformNameLWSession) {
        imageName = @"UMS_laiwang_session";
        platformName = UMLocalizedString(@"lw_session",@"点点虫");
    }
    else if(platform == UMSPlatformNameLWTimeline){
        imageName = @"UMS_laiwang_timeline";
        platformName = UMLocalizedString(@"lw_timeline",@"点点虫动态");
        }
    else if(platform == UMSPlatformNameYXSession){
        imageName = @"UMS_yixin_session";
        platformName = UMLocalizedString(@"yixin_session",@"易信");
        }
    else if(platform == UMSPlatformNameYXTimeline){
        imageName = @"UMS_yixin_timeline";
        platformName = UMLocalizedString(@"yixin_timeline",@"易信朋友圈");
        }
//    else if(platform == ){
//        imageName = @"UMS_yixin_favorite";
//        platformName = UMLocalizedString(@"yixin_favorite",@"易信收藏");
//        }
    else if(platform == UMSPlatformNameDouban) {
        imageName = @"UMS_douban_icon";
        platformName = UMLocalizedString(@"douban",@"豆瓣");
        }
    else if(platform == UMSPlatformNameRenren) {
        imageName = @"UMS_renren_icon";
        platformName = UMLocalizedString(@"renren",@"人人");
        }
    else if(platform == UMSPlatformNameEmail){
        imageName = @"UMS_email_icon";
        platformName = UMLocalizedString(@"email",@"邮箱");
        }
    else if(platform == UMSPlatformNameSms) {
        imageName = @"UMS_sms_icon";
        platformName = UMLocalizedString(@"sms",@"短信");
        }
    else if(platform == UMSPlatformNameFacebook) {
        imageName = @"UMS_facebook_icon";
        platformName = UMLocalizedString(@"facebook",@"Facebook");
        }
    else if(platform == UMSPlatformNameTwitter) {
        imageName = @"UMS_twitter_icon";
        platformName = UMLocalizedString(@"twitter",@"Twitter");
        }
    else if(platform == UMSPlatformNameInstagram) {
        imageName = @"UMS_instagram_icon";
        platformName = UMLocalizedString(@"instagram",@"Instagram");
        }
    else if(platform == UMSPlatformNameLine) {
        imageName = @"UMS_line_icon";
        platformName = UMLocalizedString(@"line",@"Line");
        }
    else if(platform == UMSPlatformNameFlickr){
        imageName = @"UMS_flickr_icon";
        platformName = UMLocalizedString(@"flickr",@"Flickr");
        }
    else if(platform == UMSPlatformNameKakaoTalk){
        imageName = @"UMS_kakao_icon";
        platformName = UMLocalizedString(@"kakaoTalk",@"KakaoTalk");
        }
    else if(platform == UMSPlatformNamePinterest){
        imageName = @"UMS_pinterest_icon";
        platformName = UMLocalizedString(@"pinterest",@"Pinterest");
        }
    else if(platform == UMSPlatformNameTumblr){
        imageName = @"UMS_tumblr_icon";
        platformName = UMLocalizedString(@"tumblr",@"Tumblr");
        }
    else if(platform == UMSPlatformNameLinkedin){
        imageName = @"UMS_linkedin_icon";
        platformName = UMLocalizedString(@"linkedin",@"Linkedin");
        }
    else if(platform == UMSPlatformNameWhatsapp){
        imageName = @"UMS_whatsapp_icon";
        platformName = UMLocalizedString(@"whatsapp",@"Whatsapp");
        }
            
    
    _imgView.image = [UIImage imageNamed:UMSocialPlatformIconWithName(imageName)];
    
    _platformLabel.text = platformName;
    
}

@end

