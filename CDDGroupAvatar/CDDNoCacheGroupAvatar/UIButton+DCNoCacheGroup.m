//
//  UIButton+DCNoCacheGroup.m
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/12/8.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import "UIButton+DCNoCacheGroup.h"

#import "UIView+DCNoCacheGroup.h"

@implementation UIButton (DCNoCacheGroup)

- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state
{
    [self dc_setNoCacheImageAvatarWithGroupId:groupId Source:groupSource forState:state itemPlaceholder:nil options:0 completed:nil];
}


- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state completed:(GroupImageBlock)completedBlock
{
    [self dc_setNoCacheImageAvatarWithGroupId:groupId Source:groupSource forState:state itemPlaceholder:nil options:0 completed:completedBlock];
}


- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state itemPlaceholder:(id)placeholder
{
    [self dc_setNoCacheImageAvatarWithGroupId:groupId Source:groupSource forState:state itemPlaceholder:placeholder options:0 completed:nil];
}


- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options completed:(GroupImageBlock)completedBlock
{
    @ga_weakify(self);
    [self dc_setNoCacheAvatarWithGroupId:groupId Source:groupSource itemPlaceholder:placeholder options:options setImageBlock:^(UIImage *setImage) {
        @ga_strongify(self);
        [self setImage:setImage forState:state];
    } completed:completedBlock];
}





- (void)dc_setNoCacheBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state
{
    
    [self dc_setNoCacheBackgroundImageAvatarWithGroupId:groupId Source:groupSource forState:state itemPlaceholder:nil options:0 completed:nil];
}


- (void)dc_setNoCacheBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state completed:(GroupImageBlock)completedBlock
{
    
    [self dc_setNoCacheBackgroundImageAvatarWithGroupId:groupId Source:groupSource forState:state itemPlaceholder:nil options:0 completed:completedBlock];
}


- (void)dc_setNoCacheBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state itemPlaceholder:(id)placeholder
{
    [self dc_setNoCacheBackgroundImageAvatarWithGroupId:groupId Source:groupSource forState:state itemPlaceholder:placeholder options:0 completed:nil];
}


- (void)dc_setNoCacheBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options completed:(GroupImageBlock)completedBlock
{
    @ga_weakify(self);
    [self dc_setNoCacheAvatarWithGroupId:groupId Source:groupSource itemPlaceholder:placeholder options:options setImageBlock:^(UIImage *setImage) {
        @ga_strongify(self);
        [self setBackgroundImage:setImage forState:state];
    } completed:completedBlock];
}



@end
