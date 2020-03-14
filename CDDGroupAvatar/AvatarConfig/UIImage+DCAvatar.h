//
//  UIImage+DCAvatar.h
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/19.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DCAvatar)

/**
 切割图片
 */
- (UIImage *)dc_cutImageViewSize:(CGSize)size clipRect:(CGRect)rect;


/**
 获取占位图
 */
- (UIImage *)dc_backItemPlaceholderImage:(id)placeholder groupCount:(NSInteger)groupCount groupIndex:(NSInteger)index;


/**
 给图片加外圈圆
 */
- (UIImage *)dc_cgContextAddArcToPointImageBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


@end

