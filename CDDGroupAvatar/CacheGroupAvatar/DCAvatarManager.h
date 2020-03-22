//
//  DCAvatarManager.h
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/20.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCAvatar.h"

#if __has_include(<SDWebImage/SDWebImage.h>)
#import <SDWebImage/SDWebImage.h>
#else
#import "SDWebImage.h"
#endif

@interface DCAvatarManager : NSObject <NSCopying>


+ (DCAvatarManager *)sharedAvatar;

#pragma mark - DCAvatarManager属性

/* 请求的baseURL。这应该只包含URL的共体部分，例如http://www.example.com。 */
@property (strong , nonatomic)NSString *baseUrl;

/* 头像类型枚举(默认微信样式) */
@property (assign , nonatomic) DCGroupAvatarType groupAvatarType;


/* 头像背景(默认微信背景色)  */
@property (nonatomic, strong) UIColor *avatarBgColor;


/* 一次性设置小头像加载失败的占位图 ： 权重低于类方法中的placeholder属性 placeholderImage < (id)placeholder  */
@property (nonatomic, strong) UIImage *placeholderImage;


/* 微信和QQ群内小头像间距（默认值：2）  */
@property (nonatomic, assign) CGFloat distanceBetweenAvatar;


/* 微博外边圈宽度（默认：10）  */
@property (nonatomic, assign) CGFloat bordWidth;


#pragma mark - SDWebImage依赖框架属性

/* sd加载群内单个小图片属性 (默认：SDWebImageRetryFailed | SDWebImageLowPriority ) */
@property (assign , nonatomic) SDWebImageOptions sdImageOptions;

@end

