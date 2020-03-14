//
//  DCAvatarHelper.h
//  DCAvatarHelper
//
//  Created by 陈甸甸 on 2019/7/18.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCAvatarConfig.h"


@interface DCAvatarHelper : NSObject

/**
 计算Type_QQ头像尺寸
 */
+ (CGSize)dc_calculateSizeQQAvatarGroupCount:(NSInteger)groupCount index:(NSInteger)index containerSize:(CGSize)containerSize distanceBetweenAvatar:(CGFloat)distance;

/**
 计算Type_WeChat头像尺寸
 */
+ (CGSize)dc_calculateSizeWeChatAvatarGroupCount:(NSInteger)groupCount containerSize:(CGSize)containerSize distanceBetweenAvatar:(CGFloat)distance;

/**
 计算Type_WeiBo圆半径
 */
+ (CGFloat)dc_calculateRadiusWeiBoAvatarGroupCount:(NSInteger)groupCount containerSize:(CGSize)containerSize distanceBetweenAvatar:(CGFloat)distance;


/**
 计算Type_WeiBo小头像位置
 */
+ (CGPoint)dc_calculateWeiBoAvatarGroupCount:(NSInteger)groupCount index:(NSInteger)index containerSize:(CGSize)containerSize distanceBetweenAvatar:(CGFloat)distance;

/**
 计算Type_WeChat/QQ小头像位置
 */
+ (CGPoint)dc_calculatePointAvatarGroupCount:(NSInteger)groupCount index:(NSInteger)index containerSize:(CGSize)containerSize distanceBetweenAvatar:(CGFloat)distance avatarType:(DCGroupAvatarType)groupAvatarType;



/**
 获取群头像最大数组数量
 */
+ (NSArray *)dc_getTypefMaxCount:(NSArray *)groupSource avatarType:(DCGroupAvatarType)groupAvatarType;


/**
判断图片属性
*/
+ (BOOL)dc_getCGImageRefContainsAlpha:(CGImageRef)imageRef;

/**
 MD5加密
 */
+ (NSString *)dc_cacheMd5:(NSString *)key;


/**
 颜色十六进制转换
 */
+ (NSString *)dc_hexColor:(UIColor *)color;


@end

