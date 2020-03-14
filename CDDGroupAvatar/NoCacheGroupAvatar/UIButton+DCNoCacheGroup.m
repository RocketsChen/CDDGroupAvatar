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
    [self dc_setNoCacheImageAvatarWithGroupId:groupId Source:groupSource forState:state completed:nil];
}


- (void)dc_setNoCacheImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state completed:(GroupImageBlock)completedBlock
{
    @ga_weakify(self);
    [self dc_setNoCacheAvatarWithGroupId:groupId Source:groupSource setImageBlock:^(UIImage *setImage) {
        @ga_strongify(self);
        [self setImage:setImage forState:state];
    } completed:completedBlock];
}







- (void)dc_setNoCacheBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state
{
    
    [self dc_setNoCacheBackgroundImageAvatarWithGroupId:groupId Source:groupSource forState:state completed:nil];
}


- (void)dc_setNoCacheBackgroundImageAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource forState:(UIControlState)state completed:(GroupImageBlock)completedBlock
{
    @ga_weakify(self);
    [self dc_setNoCacheAvatarWithGroupId:groupId Source:groupSource setImageBlock:^(UIImage *setImage) {
        @ga_strongify(self);
        [self setBackgroundImage:setImage forState:state];
    } completed:completedBlock];
}


@end
