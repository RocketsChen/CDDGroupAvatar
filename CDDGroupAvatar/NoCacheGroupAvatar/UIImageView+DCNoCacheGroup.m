//
//  UIImageView+DCNoCacheGroup.m
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/12/8.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import "UIImageView+DCNoCacheGroup.h"


@implementation UIImageView (DCNoCacheGroup)

- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource
{
    [self dc_setNoCacheImageAvatarWithGroupId:groupId Source:groupSource completed:nil];
}


- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource completed:(GroupImageBlock)completedBlock
{
    [self dc_setNoCacheAvatarWithGroupId:groupId Source:groupSource setImageBlock:nil completed:completedBlock];
}


@end
