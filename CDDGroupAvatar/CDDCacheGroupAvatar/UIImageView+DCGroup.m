//
//  UIImageView+DCGroup.m
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/20.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import "UIImageView+DCGroup.h"


@implementation UIImageView (DCGroup)


- (void)dc_setImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource
{
    [self dc_setImageAvatarWithGroupId:groupId Source:groupSource itemPlaceholder:nil options:0 completed:nil];
}


- (void)dc_setImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource completed:(GroupImageBlock)completedBlock
{
    [self dc_setImageAvatarWithGroupId:groupId Source:groupSource itemPlaceholder:nil options:0 completed:completedBlock];
}


- (void)dc_setImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource itemPlaceholder:(id)placeholder
{
    [self dc_setImageAvatarWithGroupId:groupId Source:groupSource itemPlaceholder:placeholder options:0 completed:nil];
}


- (void)dc_setImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <NSString *>*)groupSource itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options completed:(GroupImageBlock)completedBlock
{
    [self dc_setAvatarWithGroupId:groupId Source:groupSource itemPlaceholder:placeholder options:options setImageBlock:nil completed:completedBlock];
}



@end
