//
//  DCNoCahceAvatarManager.h
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/20.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCNoCacheAvatar.h"


@interface DCNoCahceAvatarManager : NSObject <NSCopying>


+ (DCNoCahceAvatarManager *)sharedAvatar;

#pragma mark - DCAvatarManager属性

/* 头像类型枚举(默认微信样式) */
@property (assign , nonatomic) DCGroupAvatarType groupAvatarType;


/* 头像背景(默认微信背景色)  */
@property (nonatomic, strong) UIColor *avatarBgColor;


/* 微信和QQ群内小头像间距（默认值：2）  */
@property (nonatomic, assign) CGFloat distanceBetweenAvatar;


/* 微博外边圈宽度（默认：10）  */
@property (nonatomic, assign) CGFloat bordWidth;


@end

