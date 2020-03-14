//
//  UIView+DCNoCacheGroup.h
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/12/8.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCNoCacheAvatar.h"

@interface UIView (DCNoCacheGroup)

/**
 设置群头像

 @param groupId 群头像id
 @param groupSource 群头像数据源数组
 @param setImageBlock 绘制好的群头像图片
 @param completedBlock <NSString *groupId, UIImage *groupImage, NSArray <UIImage *>*itemImageArray, NSString *cacheId>
 */
- (void)dc_setNoCacheAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource setImageBlock:(GroupSetImageBlock)setImageBlock completed:(GroupImageBlock)completedBlock;

@end

