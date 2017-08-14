//
//  RXUMShare.h
//  RXUMDemo2
//
//  Created by srx on 2016/10/25.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMSocialCore/UMSocialCore.h>

@interface RXUMShare : UIView
- (void)shareInController:(id)controller platforms:(NSArray <NSString *> *)platforms title:(NSString *)title contents:(NSString *)contents imageURLString:(NSString *)imageURLString completion:(void (^)(NSString * result))completion;
@end
