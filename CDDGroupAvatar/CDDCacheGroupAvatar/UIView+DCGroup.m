//
//  UIView+DCGroup.m
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/24.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import "UIView+DCGroup.h"

#import "DCAvatarManager.h"
#import "DCAvatarHelper.h"
#import "UIImage+DCAvatar.h"
#if __has_include(<SDWebImage/SDWebImage.h>)
#import <SDWebImage/SDWebImage.h>
#else
#import "SDWebImage.h"
#endif



@implementation UIView (DCGroup)


- (void)dc_setAvatarWithGroupId:(NSString *)groupId Source:(NSArray *)groupSource itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options setImageBlock:(GroupSetImageBlock)setImageBlock completed:(GroupImageBlock)completedBlock
{
    
    [self setUpAllTypeAvatarGroupId:groupId Source:groupSource itemPlaceholder:placeholder options:options setImageBlock:setImageBlock completed:^(NSString *groupId, UIImage *groupImage, NSArray<UIImage *> *itemImageArray, NSString *cacheId) {
        if (completedBlock) {
            completedBlock(groupId, groupImage, itemImageArray, cacheId);
        }
    }];
}


- (void)setUpAllTypeAvatarGroupId:(NSString *)groupId Source:(NSArray *)groupSource itemPlaceholder:(id)placeholder options:(DCGroupAvatarCacheType)options setImageBlock:(GroupSetImageBlock)setImageBlock completed:(GroupImageBlock)completedBlock
{
    @ga_weakify(self);
    __block DCGroupAvatarType avatarType = [DCAvatarManager sharedAvatar].groupAvatarType;
    
    groupSource = [DCAvatarHelper dc_getTypefMaxCount:groupSource avatarType:avatarType]; // MaxCount
    
    __block UIColor *avatarBgColor = [DCAvatarManager sharedAvatar].avatarBgColor;
    
    __block CGFloat distance = [DCAvatarManager sharedAvatar].distanceBetweenAvatar;

    __block UIImage *groupImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:DCCacheIdMD5(groupId, groupSource)]; // Cache and Disk

    __block NSArray *groupUnitImages;
    
    dispatch_main_async_safe(^{
        @ga_strongify(self);
        [self dc_setImage:groupImage setImageBlock:setImageBlock];
    });
    
    GroupImageParamsBlock callCompletedBlock = ^{ // block
        if (!self) { return; }
        if (completedBlock) {
            completedBlock(groupId, groupImage, groupUnitImages, DCCacheIdMD5(groupId, groupSource));
        }
    };
    
    
    if ((options == DCGroupAvatarCachedDefault) && groupImage) {

        groupUnitImages = [DCAvatarHelper dc_fetchItemCacheArraySource:groupSource];
        dispatch_main_async_safe(callCompletedBlock);
        
        return;
    }
    
    [DCAvatarHelper dc_fetchLoadImageSource:groupSource cacheGroupImage:groupImage itemPlaceholder:placeholder completedBlock:^(NSArray <UIImage *>*unitImages, BOOL succeed) {
        @ga_strongify(self);
        
        groupUnitImages = unitImages;
        
        CGSize itemAvaSize;
        CGPoint itemAvaPoint;
        
        CGSize containerSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        
        UIGraphicsBeginImageContextWithOptions(containerSize, NO, UIScreen.mainScreen.scale);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(ctx, avatarBgColor.CGColor);
        CGContextFillRect(ctx, CGRectMake(0, 0, containerSize.width, containerSize.height));
        
        
        if (avatarType != DCGroupAvatarWeiBoType) { // WeChat / QQ
            
            if (avatarType == DCGroupAvatarWeChatType) {
                itemAvaSize = [DCAvatarHelper dc_calculateSizeWeChatAvatarGroupCount:groupSource.count containerSize:containerSize distanceBetweenAvatar:distance];
            }
            
            for (NSInteger i = 0; i < groupUnitImages.count; ++i) {
                @autoreleasepool {
                    if (avatarType == DCGroupAvatarQQType) {
                        itemAvaSize = [DCAvatarHelper dc_calculateSizeQQAvatarGroupCount:groupSource.count index:i containerSize:containerSize distanceBetweenAvatar:distance];
                    }
                    UIImage *avatarImage = groupUnitImages[i];
                    
                    if (itemAvaSize.height != itemAvaSize.width) { // 当时不是1:1的时候需要裁减  默认是以中心和长的一边为准裁取短的
                        
                        CGFloat longEdge = MAX(itemAvaSize.height, itemAvaSize.width);
                        CGFloat shortEdge = MIN(itemAvaSize.height, itemAvaSize.width);
                        avatarImage = [avatarImage dc_cutImageViewSize:CGSizeMake(longEdge, longEdge) clipRect:CGRectMake((longEdge - shortEdge) * 0.5, 0, shortEdge, longEdge)];
                    }
                    
                    itemAvaPoint = [DCAvatarHelper dc_calculatePointAvatarGroupCount:groupUnitImages.count index:i containerSize:containerSize distanceBetweenAvatar:distance avatarType:avatarType];
                    
                    CGRect avaRect = CGRectMake(itemAvaPoint.x, itemAvaPoint.y, itemAvaSize.width, itemAvaSize.height);
                    
                    [avatarImage drawInRect:avaRect];
                }
            }
            
        }else{ // WeiBo
            
            __block CGFloat bordWidth = [DCAvatarManager sharedAvatar].bordWidth;
            
            CGFloat radius = [DCAvatarHelper dc_calculateRadiusWeiBoAvatarGroupCount:groupSource.count containerSize:containerSize distanceBetweenAvatar:distance];
            
            for (NSInteger i = 0; i < groupUnitImages.count; ++i) {
                @autoreleasepool {
                    UIImage *avatarImage = [groupUnitImages[i] dc_cgContextAddArcToPointImageBorderWidth:bordWidth borderColor:avatarBgColor]; // 画出外边框
                    
                    CGContextSaveGState(ctx);
                    
                    itemAvaPoint = [DCAvatarHelper dc_calculateWeiBoAvatarGroupCount:groupSource.count index:i containerSize:containerSize distanceBetweenAvatar:distance];
                    
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
        if (![SDImageCoderHelper CGImageContainsAlpha:unitImages.firstObject.CGImage]) {
            groupImage = [UIImage imageWithData:UIImageJPEGRepresentation(groupImage, 1.0)];
        }
        
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            @autoreleasepool {
                if (succeed) { // 如果群内部头像全部加载失败则不存，成功后在存本地
                    [[SDImageCache sharedImageCache] storeImage:groupImage forKey:DCCacheIdMD5(groupId, groupSource) toDisk:YES completion:nil]; // add Cache and Disk
                }
            }
            dispatch_main_async_safe(^{
                
                [self dc_setImage:groupImage setImageBlock:setImageBlock];
                callCompletedBlock();
            });
        });
        
    }];
}


- (void)dc_setImage:(UIImage *)groupImage setImageBlock:(GroupSetImageBlock)setImageBlock
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
