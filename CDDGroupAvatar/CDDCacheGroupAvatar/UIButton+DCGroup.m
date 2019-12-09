//
//  UIButton+DCGroup.m
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/24.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import "UIButton+DCGroup.h"

#import "UIView+DCGroup.h"


@implementation UIButton (DCGroup)


- (void)dc_setImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray *)groupSource forState:(UIControlState)state
{
    [self dc_setImageAvatarWithGroupId:groupId Source:groupSource forState:state itemPlaceholder:nil options:0 completed:nil];
}


- (void)dc_setImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray *)groupSource forState:(UIControlState)state completed:(GroupImageBlock)completedBlock
{
    [self dc_setImageAvatarWithGroupId:groupId Source:groupSource forState:state itemPlaceholder:nil options:0 completed:completedBlock];
}


- (void)dc_setImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray *)groupSource forState:(UIControlState)state itemPlaceholder:(id)placeholder
{
    [self dc_setImageAvatarWithGroupId:groupId Source:groupSource forState:state itemPlaceholder:placeholder options:0 completed:nil];
}


- (void)dc_setImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray *)groupSource forState:(UIControlState)state itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options completed:(GroupImageBlock)completedBlock
{
    @ga_weakify(self);
    [self dc_setAvatarWithGroupId:groupId Source:groupSource itemPlaceholder:placeholder options:options setImageBlock:^(UIImage *setImage) {
        @ga_strongify(self);
        [self setImage:setImage forState:state];
    } completed:completedBlock];
}





- (void)dc_setBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray *)groupSource forState:(UIControlState)state
{
    
    [self dc_setBackgroundImageAvatarWithGroupId:groupId Source:groupSource forState:state itemPlaceholder:nil options:0 completed:nil];
}


- (void)dc_setBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray *)groupSource forState:(UIControlState)state completed:(GroupImageBlock)completedBlock
{
    
    [self dc_setBackgroundImageAvatarWithGroupId:groupId Source:groupSource forState:state itemPlaceholder:nil options:0 completed:completedBlock];
}


- (void)dc_setBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray *)groupSource forState:(UIControlState)state itemPlaceholder:(id)placeholder
{
    [self dc_setBackgroundImageAvatarWithGroupId:groupId Source:groupSource forState:state itemPlaceholder:placeholder options:0 completed:nil];
}


- (void)dc_setBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray *)groupSource forState:(UIControlState)state itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options completed:(GroupImageBlock)completedBlock
{
    @ga_weakify(self);
    [self dc_setAvatarWithGroupId:groupId Source:groupSource itemPlaceholder:placeholder options:options setImageBlock:^(UIImage *setImage) {
        @ga_strongify(self);
        [self setBackgroundImage:setImage forState:state];
    } completed:completedBlock];
}

@end
