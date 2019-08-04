//
//  DCAvatarHelper.m
//  DCAvatarHelper
//
//  Created by 陈甸甸 on 2019/7/18.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import "DCAvatarHelper.h"

#import "DCAvatarManager.h"
#import "UIImage+DCAvatar.h"

#if __has_include(<SDWebImage/SDWebImage.h>)
#import <SDWebImage/SDWebImage.h>
#else
#import "SDWebImage.h"
#endif
#import <CommonCrypto/CommonDigest.h>

@implementation DCAvatarHelper

+ (CGSize)dc_calculateSizeQQAvatarGroupCount:(NSInteger)groupCount index:(NSInteger)index containerSize:(CGSize)containerSize distanceBetweenAvatar:(CGFloat)distance
{
    CGSize wholeSize = containerSize;
    CGSize avatarSize = CGSizeZero;
    
    if (groupCount == DCNumberOfGroupAvatarOne) {
        
        avatarSize = wholeSize;
        
    }else if (groupCount == DCNumberOfGroupAvatarTwo) {
        
        avatarSize = CGSizeMake((wholeSize.width - distance) / 2, wholeSize.height);
        
    }else if (groupCount == DCNumberOfGroupAvatarThree && index == 0){
        
        avatarSize = CGSizeMake((wholeSize.width - distance) / 2, wholeSize.height);
        
    }else{
        avatarSize = CGSizeMake((wholeSize.width - distance) / 2, (wholeSize.height - distance) / 2);
    }
    
    return avatarSize;
}



+ (CGSize)dc_calculateSizeWeChatAvatarGroupCount:(NSInteger)groupCount containerSize:(CGSize)containerSize distanceBetweenAvatar:(CGFloat)distance
{
    CGSize wholeSize = containerSize;
    CGSize avatarSize = CGSizeZero;

    if (groupCount < DCNumberOfGroupAvatarFive) {
        avatarSize = CGSizeMake((wholeSize.width - (3 * distance)) / 2, (wholeSize.height - (3 * distance)) / 2);
    }else{
        avatarSize = CGSizeMake((wholeSize.width - (4 * distance)) / 3, (wholeSize.height - (4 * distance)) / 3);
    }
    return avatarSize;
}


+ (CGFloat)dc_calculateRadiusWeiBoAvatarGroupCount:(NSInteger)groupCount containerSize:(CGSize)containerSize distanceBetweenAvatar:(CGFloat)distance
{
    CGFloat bigRadius = containerSize.width / 2;
    CGFloat radius = 0;
    switch (groupCount) {
            
        case DCNumberOfGroupAvatarOne:
            
            radius =  bigRadius;
            break;
            
        case DCNumberOfGroupAvatarTwo:
         
            radius =  bigRadius / 2 + (distance / 2);
            break;
       
        case DCNumberOfGroupAvatarThree:
            
            radius = (2 * sqrt(3) - 3) * bigRadius + (distance / 3);
            break;
            
        case DCNumberOfGroupAvatarFour:
            
            radius = bigRadius / 2 - (distance / 2);
            break;
            
        default:
            break;
    }

    return radius;
}


+ (CGPoint)dc_calculateWeiBoAvatarGroupCount:(NSInteger)groupCount index:(NSInteger)index containerSize:(CGSize)containerSize distanceBetweenAvatar:(CGFloat)distance
{
    CGPoint avatarPoint = CGPointZero;
    
    CGFloat avatarDiameter = [self dc_calculateRadiusWeiBoAvatarGroupCount:groupCount containerSize:containerSize distanceBetweenAvatar:distance];
    CGFloat bigRadius = containerSize.width / 2 ;
    
    CGFloat radiusOffset;
    CGFloat shrinkage = (groupCount == DCNumberOfGroupAvatarFour) ? distance : - 2 * distance ; // 收缩属性
    
    if (groupCount == DCNumberOfGroupAvatarOne) {
        
        avatarPoint = CGPointMake(containerSize.width * 0.5, containerSize.height * 0.5);
        
    } else if (groupCount == DCNumberOfGroupAvatarThree) {

        CGFloat difference = (bigRadius - avatarDiameter);

        if (index == 1) {
            
            avatarDiameter -= shrinkage;
            avatarPoint = CGPointMake(bigRadius, avatarDiameter + distance);
            
        }else{
            
            avatarDiameter += shrinkage;
            radiusOffset = index * -.5 * M_PI;
            CGFloat pX = avatarDiameter * cosf(radiusOffset);
            avatarPoint = CGPointMake(bigRadius + pX, bigRadius + (difference / 2) + distance);
        }
        
    }else{
        
        avatarDiameter += shrinkage;
        
        radiusOffset = -.75 * M_PI;
        
        CGFloat pX = avatarDiameter * cosf(2 * M_PI * index / groupCount + radiusOffset);
        CGFloat pY = avatarDiameter * sinf(2 * M_PI * index / groupCount + radiusOffset);
        
        avatarPoint = CGPointMake(bigRadius + pX, bigRadius + pY);
        
    }
    return avatarPoint;
}



+ (CGPoint)dc_calculatePointAvatarGroupCount:(NSInteger)groupCount index:(NSInteger)index containerSize:(CGSize)containerSize distanceBetweenAvatar:(CGFloat)distance avatarType:(DCGroupAvatarType)groupAvatarType
{
    CGPoint avatarPoint = CGPointZero;
    NSInteger currentIndex = index;
    CGSize avatarSize = (groupAvatarType == DCGroupAvatarWeChatType) ? [self dc_calculateSizeWeChatAvatarGroupCount:groupCount containerSize:containerSize distanceBetweenAvatar:distance] : [self dc_calculateSizeQQAvatarGroupCount:groupCount index:index containerSize:containerSize distanceBetweenAvatar:distance];
    CGFloat avaWidth = avatarSize.width;
    CGFloat avaHeight = avatarSize.height;
    CGFloat row , column;
    
    switch (groupCount) {
            
        case DCNumberOfGroupAvatarOne:
            
            if (groupAvatarType == DCGroupAvatarWeChatType) {
                
                avatarPoint = CGPointMake((containerSize.width - avaWidth)  * 0.5, (containerSize.height - avaHeight) * 0.5);
            }
            break;
            
        case DCNumberOfGroupAvatarTwo:
            if (groupAvatarType == DCGroupAvatarWeChatType) { // 微信
                
                avatarPoint = CGPointMake(currentIndex * (avaWidth + distance) + distance, (containerSize.height - avaHeight) / 2);
                
            }else if (groupAvatarType == DCGroupAvatarQQType){ // QQ
                
                avatarPoint = CGPointMake(currentIndex * (avaWidth + distance), 0);
            }
            break;
        case DCNumberOfGroupAvatarThree:
            
            if (groupAvatarType == DCGroupAvatarWeChatType) {
                
                if (currentIndex == 0) {
                    avatarPoint = CGPointMake((containerSize.width - avaWidth) / 2, distance);
                }else{
    
                    avatarPoint = CGPointMake((currentIndex - 1) * (avaWidth + distance) + distance, avaHeight + 2 * distance);
                }
            }else if (groupAvatarType == DCGroupAvatarQQType){
                
                if (currentIndex == 0) {
                    
                    avatarPoint = CGPointMake(0, 0);
                    
                }else{
                    if (currentIndex == 2) {
                        ++currentIndex;
                    }
                    column = currentIndex / 2;
                    avatarPoint = CGPointMake(avaWidth + distance, column * (avaHeight + distance));
                }
            }
            break;
        case DCNumberOfGroupAvatarFour:
            
            row = currentIndex % 2;
            column = currentIndex / 2;
            
            if (groupAvatarType == DCGroupAvatarWeChatType) {
                
                avatarPoint = CGPointMake(row * (avaWidth + distance) + distance, column * (avaHeight + distance) + distance);
                
            }else if (groupAvatarType == DCGroupAvatarQQType){
                
                avatarPoint = CGPointMake(row * (avaWidth + distance), column * (avaHeight + distance));
            }
            break;
        case DCNumberOfGroupAvatarFive:
            
            if (groupAvatarType == DCGroupAvatarWeChatType) {
                
                CGPoint tempPoint = CGPointMake((containerSize.width -  distance - (2 * avaWidth)) / 2, (containerSize.height -  distance - (2 * avaHeight)) / 2);
                if (currentIndex <= 1) {
                    avatarPoint = CGPointMake(currentIndex * (distance + avaWidth) + tempPoint.x , tempPoint.y);
                }else{
                    avatarPoint = CGPointMake((currentIndex - 2) * (avaWidth + distance) + distance, tempPoint.y + avaHeight + distance);
                }
            }
            break;
        case DCNumberOfGroupAvatarSix:
            
            
            if (groupAvatarType == DCGroupAvatarWeChatType) {
                
                CGFloat tempPointY = (containerSize.height -  distance - (2 * avaHeight)) / 2;
                
                row = currentIndex % DCMaxWeChatColumn;
                column = currentIndex / DCMaxWeChatColumn;
                avatarPoint = CGPointMake(row * (avaWidth + distance) + distance, column * (avaHeight + distance) + tempPointY);
            }
            break;
        case DCNumberOfGroupAvatarSeven:
            
            
            if (groupAvatarType == DCGroupAvatarWeChatType) {
                
                if (currentIndex == 0) {
                    avatarPoint = CGPointMake((containerSize.width - avaWidth) / 2, distance);
                    
                }else{
                    row = (currentIndex + 2) % DCMaxWeChatColumn;
                    column = (currentIndex + 2) / DCMaxWeChatColumn;
                    avatarPoint = CGPointMake(row * (avaWidth + distance) + distance, column * (avaHeight + distance) + distance);
                }
            }
            break;
        case DCNumberOfGroupAvatarEight:
            
            if (groupAvatarType == DCGroupAvatarWeChatType) {
                
                if (currentIndex < 2) {
                    
                    CGFloat tempPointX = (containerSize.width - 2 * avaWidth - distance) / 2;
                    avatarPoint = CGPointMake(currentIndex * (avaWidth + distance) + tempPointX, distance);
                    
                }else{
                    
                    row = (currentIndex + 1) % DCMaxWeChatColumn;
                    column = (currentIndex + 1)  / DCMaxWeChatColumn;
                    avatarPoint = CGPointMake(row * (avaWidth + distance) + distance, column * (avaHeight + distance) + distance);
                }
            }
            break;
        case DCNumberOfGroupAvatarNine:
            
            if (groupAvatarType == DCGroupAvatarWeChatType) {
                
                row = currentIndex % DCMaxWeChatColumn;
                column = currentIndex / DCMaxWeChatColumn;
                
                avatarPoint = CGPointMake(row * (avaWidth + distance) + distance, column * (avaHeight + distance) + distance);
                
            }
            break;
        default:
            break;
    }
    
    return avatarPoint;
}



+ (NSArray *)dc_fetchItemCacheArraySource:(NSArray <NSString *>*)groupSource
{
    UIImage *itemIamge;
    NSMutableArray *cacheArray = [NSMutableArray array];
    for (NSString *strImg in groupSource) {
        itemIamge = [[SDImageCache sharedImageCache] imageFromCacheForKey:DCURLStr(strImg)];
        if (!itemIamge) {
            itemIamge = (![DCAvatarManager sharedAvatar].placeholderImage) ? [UIImage new] : [DCAvatarManager sharedAvatar].placeholderImage;
        }
        [cacheArray addObject:itemIamge];
    }
    return cacheArray;
}


+ (void)dc_fetchLoadImageSource:(NSArray <NSString *>*)groupSource cacheGroupImage:(UIImage *)groupImage itemPlaceholder:(id)placeholder completedBlock:(FetchImageBlock)completedBlock{
    
    NSMutableArray *groupImages = [NSMutableArray arrayWithArray:groupSource];
    
    __block int32_t groupSum = 0 , placeholderSum = 0;
    __block SDWebImageOptions sdImageOptions = [DCAvatarManager sharedAvatar].sdImageOptions;
    __block BOOL succeed = NO;

    FetchImageParamsBlock callCompletedBlock = ^{ // block
        if (completedBlock) {
            completedBlock(groupImages, succeed);
        }
    };
    
    
    [groupSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                UIImage *placeholderImage = [[DCAvatarManager sharedAvatar].placeholderImage dc_backItemPlaceholderImage:placeholder groupCount:groupSource.count groupIndex:idx];
            
                if (!groupImage) {
                    placeholderSum++;
                    [groupImages replaceObjectAtIndex:idx withObject:placeholderImage];
                    if (placeholderSum == groupSource.count) {
                        dispatch_main_async_safe(callCompletedBlock)
                    }
                }
                __block NSString *strImg = (NSString *)obj;
                [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:DCURLStr(strImg)] options:sdImageOptions progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                    groupSum++;
                    
                    if (error) {
                        image = placeholderImage;
                    }else{
                        succeed = YES;
                    }
                    [groupImages replaceObjectAtIndex:idx withObject:image];
                    if (groupSum == groupSource.count) {
                        dispatch_main_async_safe(callCompletedBlock)
                    }
                }];
            }
        });
    }];
}


+ (NSArray *)dc_getTypefMaxCount:(NSArray <NSString *>*)groupSource avatarType:(DCGroupAvatarType)groupAvatarType
{
    if (groupAvatarType == DCGroupAvatarWeChatType) {
        return [groupSource subarrayWithRange:NSMakeRange(0, MIN(groupSource.count, DCMaxWeChatCount))];
    }else if (groupAvatarType == DCGroupAvatarQQType){
        return [groupSource subarrayWithRange:NSMakeRange(0, MIN(groupSource.count, DCMaxQQCount))];
    }else if (groupAvatarType == DCGroupAvatarWeiBoType){
        return [groupSource subarrayWithRange:NSMakeRange(0, MIN(groupSource.count, DCMaxWeiBoCount))];
    }
    return [NSArray array];
}


+ (NSString *)dc_cacheMd5:(NSString *)key{
    const char *str = key.UTF8String;
    if (str == NULL) {
        str = "";
    }
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    return outputString;
}


+ (NSString *)dc_hexColor:(UIColor *)color {

    CGFloat red, green, blue, alpha;
    
    if (![color getRed:&red green:&green blue:&blue alpha:&alpha]) {
        [color getWhite:&red alpha:&alpha];
        green = red;
        blue = red;
    }
    red = roundf(red * 255.f);
    green = roundf(green * 255.f);
    blue = roundf(blue * 255.f);
    alpha = roundf(alpha * 255.f);
    
    uint hex = ((uint)alpha << 24) | ((uint)red << 16) | ((uint)green << 8) | ((uint)blue);
    return [NSString stringWithFormat:@"#%08x", hex];
}


@end
