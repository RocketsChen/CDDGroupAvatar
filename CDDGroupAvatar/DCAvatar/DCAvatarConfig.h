//
//  DCAvatarConfig.h
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/20.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#ifndef DCAvatarConfig_h
#define DCAvatarConfig_h

// Block

typedef void(^GroupImageBlock)(NSString *groupId, UIImage *groupImage, NSArray <UIImage *>*itemImageArray, NSString *cacheId);

typedef void(^GroupSetImageBlock)(UIImage *setImage);

typedef void(^GroupImageParamsBlock)(void);


typedef void(^FetchImageBlock)(NSArray <UIImage *>*unitImages, BOOL succeed);

typedef void(^AsynFetchImageBlock)(NSArray <UIImage *>*unitImages);

typedef void(^FetchImageParamsBlock)(void);

// static

static int32_t DCMaxWeChatCount = 9;
static int32_t DCMaxQQCount     = 4;
static int32_t DCMaxWeiBoCount  = 4;

static int32_t DCMaxWeChatColumn  = 3;

static CGFloat DCDistanceBetweenAvatar  = 2;
static CGFloat DCWeiBoAvatarbordWidth   = 10;



// ENUM


/**
 头像类型枚举

 - DCGroupAvatarWeChatType: 微信
 - DCGroupAvatarNewQQType:  QQ（以中心点分割的半圆拼接）
 - DCGroupAvatarOldQQType:  WeiBo（圆拼接）
 */
typedef NS_ENUM(NSUInteger, DCGroupAvatarType) {
    DCGroupAvatarWeChatType = 0,
    DCGroupAvatarQQType     = 1,
    DCGroupAvatarWeiBoType  = 2,
};



/**
 加载图片枚举 * cache
 
 - SDCGroupAvatarDefaultCached: 默认：走缓存 取到返回 没有则获取最新
 - SDCGroupAvatarRefreshCached: 先读缓存再获取最新
 */
typedef NS_ENUM(NSUInteger, DCGroupAvatarCacheType) {
    
    DCGroupAvatarCachedDefault = 0,
    
    DCGroupAvatarCachedRefresh = 1,
};



/**
 组内头像的数量

 - DCNumberOfGroupAvatarOne: 1
 - DCNumberOfGroupAvatarTwo: 2
 - DCNumberOfGroupAvatarThree: 3
 - DCNumberOfGroupAvatarFour: 4 (QQ最大值) / (微博最大值)
 - DCNumberOfGroupAvatarFive: 5
 - DCNumberOfGroupAvatarSix: 6
 - DCNumberOfGroupAvatarSeven: 7
 - DCNumberOfGroupAvatarEight: 8
 - DCNumberOfGroupAvatarNine: 9 (微信最大值)
 */
typedef NS_ENUM(NSUInteger, DCNumberOfGroupAvatarType) {
    
    DCNumberOfGroupAvatarOne   = 1,
    DCNumberOfGroupAvatarTwo   = 2,
    DCNumberOfGroupAvatarThree = 3,
    DCNumberOfGroupAvatarFour  = 4,
    DCNumberOfGroupAvatarFive  = 5,
    DCNumberOfGroupAvatarSix   = 6,
    DCNumberOfGroupAvatarSeven = 7,
    DCNumberOfGroupAvatarEight = 8,
    DCNumberOfGroupAvatarNine  = 9,
};


// define

// * cache
#define DCURLStr(avaStr) ([avaStr containsString:@"www."]) ? avaStr : [NSString stringWithFormat:@"%@%@",[DCAvatarManager sharedAvatar].baseUrl,avaStr]


#define DCCacheIdMD5(groupId,groupSource) [DCAvatarHelper dc_cacheMd5:[NSString stringWithFormat:@"id%@_num%zd_lastObj%@_distance%.f_bordWidth%.f_bgColor%@",groupId,groupSource.count,groupSource.lastObject,[DCAvatarManager sharedAvatar].distanceBetweenAvatar,[DCAvatarManager sharedAvatar].bordWidth,[DCAvatarHelper dc_hexColor:[DCAvatarManager sharedAvatar].avatarBgColor]]]


#define DCNoCacheIdMD5(groupId,groupSource) [DCAvatarHelper dc_cacheMd5:[NSString stringWithFormat:@"id%@_num%zd_lastObj%@_distance%.f_bordWidth%.f_bgColor%@",groupId,groupSource.count,groupSource.lastObject,[DCNoCahceAvatarManager sharedAvatar].distanceBetweenAvatar,[DCNoCahceAvatarManager sharedAvatar].bordWidth,[DCAvatarHelper dc_hexColor:[DCNoCahceAvatarManager sharedAvatar].avatarBgColor]]]



#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(dispatch_get_main_queue())) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

#ifndef ga_weakify
#if DEBUG
#if __has_feature(objc_arc)
#define ga_weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define ga_weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define ga_weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define ga_weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef ga_strongify
#if DEBUG
#if __has_feature(objc_arc)
#define ga_strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define ga_strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define ga_strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define ga_strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#endif /* DCAvatarConfig_h */
