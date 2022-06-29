//
//  UIView+DCGroup.h
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/24.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCAvatar.h"


@interface UIView (DCGroup)

/**
 设置群头像

 @param groupId 群头像id
 @param groupSource 群头像数据源数组
 @param cacheKeys 自定义缓存 例：@[@"md51",@"md52"] 用于特殊需求自定义缓存路径-cacheKeys参数 
 @param placeholder 占位图 例：@[@"p1",@"p2"] 或者 @[image1,image2] 权重大于 placeholderImage属性
 @param options 加载图片选项，详情可见DCGroupAvatarCacheType枚举
 @param setImageBlock 绘制好的群头像图片
 @param completedBlock <NSString *groupId, UIImage *groupImage, NSArray <UIImage *>*itemImageArray, NSString *cacheId>
 */
- (void)dc_setAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource cacheKeys:(NSArray <NSString *>*)cacheKeys itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options setImageBlock:(GroupSetImageBlock)setImageBlock completed:(GroupImageBlock)completedBlock;

@end

