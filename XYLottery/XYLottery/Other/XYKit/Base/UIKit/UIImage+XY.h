//
//  UIImage+XY.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XY)

/**
 通过图片名称返回图片
 
 @param name 图片名
 @return 对应图片
 */
+ (instancetype)imageWithName:(NSString *)name;


/**
 通过图片名返回一张被拉伸之后的图片

 @param name 图片名
 @return 被拉伸之后的图片
 */
+ (UIImage *)resiedImageWithName:(NSString *)name;


/**
 通过图片名返回一张被拉伸之后的图片

 @param name 图片名
 @param left 拉伸左侧的比例
 @param top 拉伸上部比例
 @return 被拉伸之后的图片
 */
+ (UIImage *)resiedImageWithName:(NSString *)name left:(CGFloat )left top:(CGFloat)top;

@end
