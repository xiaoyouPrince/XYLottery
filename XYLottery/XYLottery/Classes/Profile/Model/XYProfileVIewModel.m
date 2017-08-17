//
//  XYProfileVIewModel.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/17.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYProfileVIewModel.h"

@implementation XYProfileVIewModel

#define k_checkinUrl @"http://115.29.175.83/cpyc/checkin.php?userid=629087&sessionid=3ad73c7eb137ccca01cc4245fd2c8710"

- (void)checkinSuccess:(void (^) (BOOL success))success
{
    [XYHttpTool getWithURL:k_checkinUrl params:nil success:^(NSDictionary * json) {
        
        [SVProgressHUD showSuccessWithStatus:json[@"message"]];
        
        if (![json[@"errorcode"] boolValue]) {
            // 有错误已经签到,不做操作
        }else
        {
            // 没有错误，提示完成之后刷新页面
            success(YES);
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        
    }];
}

@end
