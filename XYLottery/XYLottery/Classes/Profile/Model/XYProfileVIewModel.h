//
//  XYProfileVIewModel.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/17.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYProfileVIewModel : NSObject


/**
 用户点击登录的操作

 @param success 成功回调
 */
- (void)checkinSuccess:(void (^) (BOOL success))success;

@end
