//
//  UIView+DCNoCacheGroup.m
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/12/8.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import "UIView+DCNoCacheGroup.h"
#import "DCNoCahceAvatarManager.h"
#import "DCNoCacheAvatarHelper.h"
#import "UIImage+DCAvatar.h"

@implementation UIView (DCNoCacheGroup)

- (void)dc_setNoCacheAvatarWithGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options setImageBlock:(GroupSetImageBlock)setImageBlock completed:(GroupImageBlock)completedBlock
{
    [self setUpNoCacheAllTypeAvatarGroupId:groupId Source:groupSource itemPlaceholder:placeholder options:options setImageBlock:setImageBlock completed:^(NSString *groupId, UIImage *groupImage, NSArray<UIImage *> *itemImageArray, NSString *cacheId) {
        if (completedBlock) {
            completedBlock(groupId, groupImage, itemImageArray, cacheId);
        }
    }];
}


- (void)setUpNoCacheAllTypeAvatarGroupId:(NSString *)groupId Source:(NSArray <UIImage *>*)groupSource itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options setImageBlock:(GroupSetImageBlock)setImageBlock completed:(GroupImageBlock)completedBlock
{

    DCGroupAvatarType avatarType = [DCNoCahceAvatarManager sharedAvatar].groupAvatarType;
    
    groupSource = [DCNoCacheAvatarHelper dc_getTypefMaxCount:groupSource avatarType:avatarType]; // MaxCount
    
    UIColor *avatarBgColor = [DCNoCahceAvatarManager sharedAvatar].avatarBgColor;
    
    CGFloat distance = [DCNoCahceAvatarManager sharedAvatar].distanceBetweenAvatar;
    
    UIImage *groupImage;
    
    GroupImageParamsBlock callCompletedBlock = ^{ // block
        if (!self) { return; }
        if (completedBlock) {
            completedBlock(groupId, groupImage, groupSource, DCNoCacheIdMD5(groupId, groupSource));
        }
    };
    
    CGSize itemAvaSize;
    CGPoint itemAvaPoint;
    
    CGSize containerSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    UIGraphicsBeginImageContextWithOptions(containerSize, NO, UIScreen.mainScreen.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, avatarBgColor.CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, containerSize.width, containerSize.height));
    
    if (avatarType != DCGroupAvatarWeiBoType) { // WeChat / QQ
        
        if (avatarType == DCGroupAvatarWeChatType) {
            itemAvaSize = [DCNoCacheAvatarHelper dc_calculateSizeWeChatAvatarGroupCount:groupSource.count containerSize:containerSize distanceBetweenAvatar:distance];
        }
        
        for (NSInteger i = 0; i < groupSource.count; ++i) {
            @autoreleasepool {
                if (avatarType == DCGroupAvatarQQType) {
                    itemAvaSize = [DCNoCacheAvatarHelper dc_calculateSizeQQAvatarGroupCount:groupSource.count index:i containerSize:containerSize distanceBetweenAvatar:distance];
                }
                UIImage *avatarImage = groupSource[i];
                
                if (itemAvaSize.height != itemAvaSize.width) { // 当时不是1:1的时候需要裁减  默认是以中心和长的一边为准裁取短的
                    
                    CGFloat longEdge = MAX(itemAvaSize.height, itemAvaSize.width);
                    CGFloat shortEdge = MIN(itemAvaSize.height, itemAvaSize.width);
                    avatarImage = [avatarImage dc_cutImageViewSize:CGSizeMake(longEdge, longEdge) clipRect:CGRectMake((longEdge - shortEdge) * 0.5, 0, shortEdge, longEdge)];
                }
                
                itemAvaPoint = [DCNoCacheAvatarHelper dc_calculatePointAvatarGroupCount:groupSource.count index:i containerSize:containerSize distanceBetweenAvatar:distance avatarType:avatarType];
                
                CGRect avaRect = CGRectMake(itemAvaPoint.x, itemAvaPoint.y, itemAvaSize.width, itemAvaSize.height);
                
                [avatarImage drawInRect:avaRect];
            }
        }
        
    }else{ // WeiBo
        
        __block CGFloat bordWidth = [DCNoCahceAvatarManager sharedAvatar].bordWidth;
        
        CGFloat radius = [DCNoCacheAvatarHelper dc_calculateRadiusWeiBoAvatarGroupCount:groupSource.count containerSize:containerSize distanceBetweenAvatar:distance];
        
        for (NSInteger i = 0; i < groupSource.count; ++i) {
            @autoreleasepool {
                UIImage *avatarImage = [groupSource[i] dc_cgContextAddArcToPointImageBorderWidth:bordWidth borderColor:avatarBgColor]; // 画出外边框
                
                CGContextSaveGState(ctx);
                
                itemAvaPoint = [DCNoCacheAvatarHelper dc_calculateWeiBoAvatarGroupCount:groupSource.count index:i containerSize:containerSize distanceBetweenAvatar:distance];
                
                CGContextAddArc(ctx, itemAvaPoint.x, itemAvaPoint.y, radius, 0, M_PI * 2, 1);
                
                CGContextClosePath(ctx);
                CGContextClip(ctx);
                
                CGRect avatarRect = CGRectMake(itemAvaPoint.x - radius, itemAvaPoint.y - radius, radius * 2, radius * 2);
                
                [avatarImage drawInRect:avatarRect];
                
                CGContextRestoreGState(ctx);
            }
        }
    }
    
    groupImage = UIGraphicsGetImageFromCurrentImageContext();
    if (![DCNoCacheAvatarHelper dc_getCGImageRefContainsAlpha:groupSource.firstObject.CGImage]) {
        groupImage = [UIImage imageWithData:UIImageJPEGRepresentation(groupImage, 1.0)];
    }
    UIGraphicsEndImageContext();
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_main_async_safe(^{
            [self dc_noCachesetImage:groupImage setImageBlock:setImageBlock];
            callCompletedBlock();
        });
    });
}



- (void)dc_noCachesetImage:(UIImage *)groupImage setImageBlock:(GroupSetImageBlock)setImageBlock
{
    if (!groupImage) return;
    UIView *view = self;
    GroupSetImageBlock finishSetBlock;
    
    if (setImageBlock) {
        finishSetBlock = setImageBlock;
    } else if ([view isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)view;
        finishSetBlock = ^(UIImage *setImage) {
            imageView.image = setImage;
        };
    }else if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;
        finishSetBlock = ^(UIImage *setImage) {
            [button setImage:setImage forState:UIControlStateNormal];
        };
    }
    if (finishSetBlock) {
        finishSetBlock(groupImage);
    }
}

@end
