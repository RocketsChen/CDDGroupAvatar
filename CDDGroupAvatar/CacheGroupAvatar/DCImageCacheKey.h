//
//  DCImageCacheKey.h
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2022/6/29.
//  Copyright © 2022 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<SDWebImage/SDWebImage.h>)
#import <SDWebImage/SDWebImage.h>
#else
#import "SDWebImage.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface DCImageCacheKey : NSObject <SDWebImageCacheKeyFilter>

@property (nonatomic, strong) NSString *cacheKey;

@end

NS_ASSUME_NONNULL_END
