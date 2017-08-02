//
//  UIImage+XY.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "UIImage+XY.h"

@implementation UIImage (XY)


+ (instancetype)imageWithName:(NSString *)name{
    
    return [UIImage imageNamed:name];
}

+ (UIImage *)resiedImageWithName:(NSString *)name
{
    return [self resiedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resiedImageWithName:(NSString *)name left:(CGFloat )left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}
@end
