//
//  XYAccountTool.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/11.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYAccountTool.h"
#import "XYUser.h"

#define UserFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.data"]

@implementation XYAccountTool

#pragma mark-- User
/**
 *  登录user保存
 */
+ (void)saveUser:(XYUser *)user
{
    if (user == nil) {
        return;
    }
    // 1.归档token
    [NSKeyedArchiver archiveRootObject:user toFile:UserFilePath];
}
/**
 *  取user
 */
+ (XYUser *)user{
    
    XYUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:UserFilePath];
    
    if (user == nil) {
        return nil;
    }else
    {
        return user;
    }
    
}

/**
 *  删除user
 */
+ (void)deleteUser
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:UserFilePath]) {
        [manager removeItemAtPath:UserFilePath error:nil];
    }
}

@end
