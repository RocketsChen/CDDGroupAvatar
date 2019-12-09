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
 批量加载群内部小头像（同步-M）
 
 @param groupSource 群头像数据源数组
 @param placeholder 占位图 例：@[@"p1",@"p2"] 或者 @[image1,image2] 权重大于 placeholderImage属性
 */
+ (NSArray *)dc_synfetchLoadImageSource:(NSArray *)groupSource itemPlaceholder:(id)placeholder;

/**
 批量加载群内部小头像（异步-M）
 
 @param groupSource 群头像数据源数组
 @param placeholder 占位图 例：@[@"p1",@"p2"] 或者 @[image1,image2] 权重大于 placeholderImage属性
 */
+ (void)dc_asynfetchLoadImageSource:(NSArray *)groupSource itemPlaceholder:(id)placeholder completedBlock:(AsynFetchImageBlock)completedBlock;



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
 批量加载群内部小头像
 */
+ (void)dc_fetchLoadImageSource:(NSArray *)groupSource cacheGroupImage:(UIImage *)groupImage itemPlaceholder:(id)placeholder completedBlock:(FetchImageBlock)completedBlock;



/**
 获取群头像内部小头像缓存数组
 */
+ (NSArray *)dc_fetchItemCacheArraySource:(NSArray *)groupSource;


/**
 获取群头像最大数组数量
 */
+ (NSArray *)dc_getTypefMaxCount:(NSArray *)groupSource avatarType:(DCGroupAvatarType)groupAvatarType;



/**
 MD5加密
 */
+ (NSString *)dc_cacheMd5:(NSString *)key;


/**
 颜色十六进制转换
 */
+ (NSString *)dc_hexColor:(UIColor *)color;


@end

