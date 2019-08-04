//
//  UIImage+DCAvatar.m
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/19.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import "UIImage+DCAvatar.h"

@implementation UIImage (DCAvatar)


- (UIImage *)dc_cutImageViewSize:(CGSize)size clipRect:(CGRect)rect {

    UIImage *clipImage = self;
    
    CGFloat scale_width = self.size.width / size.width;
    CGFloat scale_height = self.size.height / size.height;
    CGRect clipRect = CGRectMake(rect.origin.x * scale_width,rect.origin.y * scale_height,rect.size.width * scale_width,rect.size.height * scale_height);
    UIGraphicsBeginImageContext(clipRect.size);
    [self drawAtPoint:CGPointMake(- clipRect.origin.x, - clipRect.origin.y)];
    clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return clipImage;
}


- (UIImage *)dc_backItemPlaceholderImage:(id)placeholder groupCount:(NSInteger)groupCount groupIndex:(NSInteger)index;
{
    UIImage *itemPlaceholder = self;
    
    if ([placeholder isKindOfClass:[NSString class]]) {
        
        itemPlaceholder = [UIImage imageNamed:placeholder];
        
    }else if ([placeholder isKindOfClass:[NSArray class]]) {
        
        NSArray *placeholderArray = (NSArray *)placeholder;
        
        if (placeholderArray.count >= groupCount) {
            
            id item = placeholder[index];
            
            if ([item isKindOfClass:[NSString class]]) {
                itemPlaceholder = [UIImage imageNamed:(NSString *)item];
            }else if ([item isKindOfClass:[UIImage class]]){
                itemPlaceholder = (UIImage *)item;
            }
        }
    }else if ([placeholder isKindOfClass:[UIImage class]]) {
        
        itemPlaceholder = (UIImage *)placeholder;
    }
    return itemPlaceholder;
}


- (UIImage *)dc_cgContextAddArcToPointImageBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UIImage *avatarImage = self;
    
    CGSize size = CGSizeMake(avatarImage.size.width + 2 * borderWidth, avatarImage.size.height + 2 * borderWidth);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [borderColor set];
    [path fill];
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, avatarImage.size.width, avatarImage.size.height)];
    [path addClip];
    [avatarImage drawInRect:CGRectMake(borderWidth, borderWidth, avatarImage.size.width, avatarImage.size.height)];
    avatarImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return avatarImage;
}





@end
