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
    return @"6f56e55b71ba520cddc64918595d0e72";
}

- (NSString *)key
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
        
    return timeString;
}


@end
