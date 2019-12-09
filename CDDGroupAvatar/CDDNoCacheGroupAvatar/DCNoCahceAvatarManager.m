//
//  DCNoCahceAvatarManager.m
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/20.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import "DCNoCahceAvatarManager.h"

@implementation DCNoCahceAvatarManager

+ (DCNoCahceAvatarManager *)sharedAvatar {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}


- (instancetype)init {
    self = [super init];
    if (self) {

        [self initBaseValue];
    }
    return self;
}


- (void)initBaseValue {
    _placeholderImage = [UIImage new];
    _bordWidth = DCWeiBoAvatarbordWidth;
    _distanceBetweenAvatar = DCDistanceBetweenAvatar;
    _avatarBgColor = [UIColor colorWithRed:238 / 255.0f  green:238 / 255.0f  blue:238 / 255.0f  alpha:1.0f];
}


- (void)setAvatarBgColor:(UIColor *)avatarBgColor
{
    _avatarBgColor = avatarBgColor;
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
}

- (void)setDistanceBetweenAvatar:(CGFloat)distanceBetweenAvatar
{
    _distanceBetweenAvatar = distanceBetweenAvatar;
}

- (void)setBordWidth:(CGFloat)bordWidth
{
    _bordWidth = bordWidth;
}

@end
