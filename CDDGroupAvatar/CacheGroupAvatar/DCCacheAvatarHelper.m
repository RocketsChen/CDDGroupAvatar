//
//  DCCacheAvatarHelper.m
//  
//
//  Created by 陈甸甸 on 2019/12/10.
//

#import "DCCacheAvatarHelper.h"


#if __has_include(<SDWebImage/SDWebImage.h>)
#import <SDWebImage/SDWebImage.h>
#else
#import "SDWebImage.h"
#endif

@implementation DCCacheAvatarHelper



+ (NSArray *)dc_fetchItemCacheArraySource:(NSArray *)groupSource
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


+ (void)dc_fetchLoadImageSource:(NSArray *)groupSource cacheKeys:(NSArray <NSString *>*)cacheKeys cacheGroupImage:(UIImage *)groupImage itemPlaceholder:(id)placeholder completedBlock:(FetchImageBlock)completedBlock{
    
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
            
            NSString *cacheKey = cacheKeys[idx];
            SDWebImageContext *imageContext = nil;
            if (cacheKey.length > 0) {
                DCImageCacheKey *cache = [DCImageCacheKey new];
                cache.cacheKey = cacheKey;
                imageContext = [SDWebImageContext dictionaryWithObject:cache forKey:SDWebImageContextCacheKeyFilter];
            }
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:DCURLStr(strImg)] options:sdImageOptions context:imageContext progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                @autoreleasepool {
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
                }
            }];
        }
    }];
}



+ (NSArray *)dc_synfetchLoadImageSource:(NSArray *)groupSource itemPlaceholder:(id)placeholder
{
    __block NSMutableArray *allItemImages;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [self dc_fetchLoadImageSource:groupSource cacheKeys:nil cacheGroupImage:nil itemPlaceholder:placeholder completedBlock:^(NSArray<UIImage *> *unitImages, BOOL succeed) {
        allItemImages = [NSMutableArray arrayWithArray:unitImages];
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return allItemImages;
}


+ (void)dc_asynfetchLoadImageSource:(NSArray *)groupSource itemPlaceholder:(id)placeholder completedBlock:(AsynFetchImageBlock)completedBlock
{
    [self dc_fetchLoadImageSource:groupSource cacheKeys:nil cacheGroupImage:nil itemPlaceholder:placeholder completedBlock:^(NSArray<UIImage *> *unitImages, BOOL succeed) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completedBlock(unitImages);
        });
    }];
}



@end
