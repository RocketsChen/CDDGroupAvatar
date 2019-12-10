//
//  UIButton+DCNoCacheGroup.h
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/12/8.
//  Copyright © 2019 RocketsChen. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIView+DCNoCacheGroup.h"

@interface UIButton (DCNoCacheGroup)

/**
 设置群头像

 @param groupId 群头像id
 @param groupSource 群头像数据源数组
 @param state UIControlState
 */
- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state;


/**
 设置群头像

 @param groupId 群头像id
 @param groupSource 群头像数据源数组
 @param state UIControlState
 @param completedBlock <NSString *groupId, UIImage *groupImage, NSArray <UIImage *>*itemImageArray, NSString *cacheId>
 */
- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state completed:(GroupImageBlock)completedBlock;



/**
 设置群头像（按钮背景）
  */
- (void)dc_setNoCacheBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state;


- (void)dc_setNoCacheBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state completed:(GroupImageBlock)completedBlock;


@end

