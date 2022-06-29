//
//  DCImageCacheKey.m
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2022/6/29.
//  Copyright © 2022 RocketsChen. All rights reserved.
//

#import "DCImageCacheKey.h"

@implementation DCImageCacheKey

- (nullable NSString *)cacheKeyForURL:(nonnull NSURL *)url {
    return _cacheKey;
}

@end
