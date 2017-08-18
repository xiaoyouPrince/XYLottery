//
//  XYSurveyCache.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/18.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYSurveyCache.h"

@implementation XYSurveyCache

- (NSString *)createtime
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    if (_createtime) {
        return _createtime;
    }else
    {
        return timeString;
    }
}

- (NSString *)status
{
    return @"1";
}

- (void)setModel:(XYSurveyListModel *)model
{
    
}

MJCodingImplementation

@end


