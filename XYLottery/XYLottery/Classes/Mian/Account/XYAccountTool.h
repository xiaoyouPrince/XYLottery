//
//  XYAccountTool.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/11.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYUser;

@interface XYAccountTool : NSObject


#pragma mark -- user
/**
 *  登录user保存
 */
+ (void)saveUser:(XYUser *)user;
/**
 *  取user
 */
+ (XYUser *)user;

/**
 *  删除user
 */
+ (void)deleteUser;


@end
