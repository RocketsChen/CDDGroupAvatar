//
//  UIButton+DCGroup.h
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/24.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCAvatarConfig.h"

@interface UIButton (DCGroup)


/**
 设置群头像

 @param groupId 群头像id
 @param groupSource 群头像数据源数组
 @param state UIControlState
 */
- (void)dc_setImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource forState:(UIControlState)state;


/**
 设置群头像

 @param groupId 群头像id
 @param groupSource 群头像数据源数组
 @param state UIControlState
 @param completedBlock <NSString *groupId, UIImage *groupImage, NSArray <UIImage *>*itemImageArray, NSString *cacheId>
 */
- (void)dc_setImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource forState:(UIControlState)state completed:(GroupImageBlock)completedBlock;


/**
 设置群头像

 @param groupId 群头像id
 @param groupSource 群头像数据源数组
 @param state UIControlState
 @param placeholder 占位图 例：@[@"p1",@"p2"] 或者 @[image1,image2] 权重大于 placeholderImage属性
 */
- (void)dc_setImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource forState:(UIControlState)state itemPlaceholder:(id)placeholder;


/**
 设置群头像

 @param groupId 群头像id
 @param groupSource 群头像数据源数组
 @param state UIControlState
 @param placeholder 占位图 例：@[@"p1",@"p2"] 或者 @[image1,image2] 权重大于 placeholderImage属性
 @param options 加载图片选项，详情可见DCGroupAvatarCacheType枚举
 @param completedBlock <NSString *groupId, UIImage *groupImage, NSArray <UIImage *>*itemImageArray, NSString *cacheId>
 */
- (void)dc_setImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource forState:(UIControlState)state itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options completed:(GroupImageBlock)completedBlock;


/**
 设置群头像（按钮背景）
  */
- (void)dc_setBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource forState:(UIControlState)state;


- (void)dc_setBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource forState:(UIControlState)state completed:(GroupImageBlock)completedBlock;


- (void)dc_setBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource forState:(UIControlState)state itemPlaceholder:(id)placeholder;


- (void)dc_setBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource forState:(UIControlState)state itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options completed:(GroupImageBlock)completedBlock;


@end

