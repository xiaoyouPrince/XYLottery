//
//  XYRequestParam.m
//  BBAngel
//
//  Created by Xiaoyou on 16/8/27.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import "XYRequestParam.h"

@implementation XYRequestParam

/**
 *  初始化
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//http://115.29.175.83/cpyc/getprecalc.php?lastid=-1&playtype=1038&lottype=1005&ctype=1&iosversion=1.4.5&issuenum=7&token=6f56e55b71ba520cddc64918595d0e72&key=1501660575


- (NSString *)lastid
{
    if (_lastid) {
        return _lastid;
    }else
    {
        return @"-1";
    }
}

- (NSString *)ctype
{
    return @"1";
}

- (NSString *)iosversion
{
    return @"1.4.5";
}

- (NSString *)token
{
    if (_token) {
        return _token; // 这个是注册时候的一个token
    }else
    {
        // 这个是请求本次上次预测的token
        return @"6f56e55b71ba520cddc64918595d0e72";
    }
}

- (NSString *)key
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
        
    return timeString;
}

- (NSString *)userid
{
    if ([XYAccountTool user].userid) {
        return [XYAccountTool user].userid;
    }else
    {
        return @"629087"; // 这个是默认（注册不成功之后，假的备用）
    }
}

- (NSString *)mac
{
    return @"21BE3D7F-AFAF-4513-9577-7A005CDE8F77";
}

- (NSString *)sessionid
{
    return @"3ad73c7eb137ccca01cc4245fd2c8710"; //  在现在有账号下可用（629087）   
}

- (NSNumber *)device
{
    return @1;
}

- (NSString *)channel
{
    return @"iosiphone";
}
- (NSString *)data
{
    return @"82549e24b41e2bd11482dd04f24bcd88";
}
- (NSString *)breif
{
    if (_breif) {
        return _breif;
    }else
    {
        return @"";
    }
}


@end
