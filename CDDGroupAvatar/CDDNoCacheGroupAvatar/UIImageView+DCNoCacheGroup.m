//
//  UIImageView+DCNoCacheGroup.m
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/12/8.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import "UIImageView+DCNoCacheGroup.h"

#import "UIView+DCNoCacheGroup.h"

@implementation UIImageView (DCNoCacheGroup)

- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource
{
    [self dc_setNoCacheImageAvatarWithGroupId:groupId Source:groupSource itemPlaceholder:nil options:0 completed:nil];
}


- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource completed:(GroupImageBlock)completedBlock
{
    [self dc_setNoCacheImageAvatarWithGroupId:groupId Source:groupSource itemPlaceholder:nil options:0 completed:completedBlock];
}


- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource itemPlaceholder:(id)placeholder
{
    [self dc_setNoCacheImageAvatarWithGroupId:groupId Source:groupSource itemPlaceholder:placeholder options:0 completed:nil];
}


- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options completed:(GroupImageBlock)completedBlock
{
    [self dc_setNoCacheAvatarWithGroupId:groupId Source:groupSource itemPlaceholder:placeholder options:options setImageBlock:nil completed:completedBlock];
}

@end
