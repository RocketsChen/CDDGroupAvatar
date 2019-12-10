//
//  DCCacheAvatarHelper.h
//  
//
//  Created by 陈甸甸 on 2019/12/10.
//

#import "DCAvatarHelper.h"

@interface DCCacheAvatarHelper : DCAvatarHelper



/**
 批量加载群内部小头像
 */
+ (void)dc_fetchLoadImageSource:(NSArray *)groupSource cacheGroupImage:(UIImage *)groupImage itemPlaceholder:(id)placeholder completedBlock:(FetchImageBlock)completedBlock;



/**
 获取群头像内部小头像缓存数组
 */
+ (NSArray *)dc_fetchItemCacheArraySource:(NSArray *)groupSource;



/**
 批量加载群内部小头像（同步-M）
 
 @param groupSource 群头像数据源数组
 @param placeholder 占位图 例：@[@"p1",@"p2"] 或者 @[image1,image2] 权重大于 placeholderImage属性
 */
+ (NSArray *)dc_synfetchLoadImageSource:(NSArray *)groupSource itemPlaceholder:(id)placeholder;



/**
 批量加载群内部小头像（异步-M）
 
 @param groupSource 群头像数据源数组
 @param placeholder 占位图 例：@[@"p1",@"p2"] 或者 @[image1,image2] 权重大于 placeholderImage属性
 */
+ (void)dc_asynfetchLoadImageSource:(NSArray *)groupSource itemPlaceholder:(id)placeholder completedBlock:(AsynFetchImageBlock)completedBlock;




@end

