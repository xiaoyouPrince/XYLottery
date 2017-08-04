//
//  XYTools.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/3.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYTools.h"

@implementation XYTools

+ (XYLotteryData *)lotteryData
{
    XYLotteryData *data = [XYLotteryData objectWithFilename:@"lotteryData.plist"];
    return data;
}

+ (XYIssueModel *)issueModel
{
    XYIssueModel *data = [XYIssueModel objectWithFilename:@"issuenum.plist"];
    return data;
}

+ (XYLottery *)lotteryWithName:(NSString *)lotName
{
    NSArray *lots = [self lotteryData].list;
    
    for (XYLottery *lot in lots) {
        if ([lot.lotname isEqualToString:lotName]) {
            return lot;
        }
    }
    
    return [XYLottery new];
}

+ (NSString *)issuenumWithName:(NSString *)name{
    
    NSArray *issues = [self issueModel].issues;
    
    for (XYIssue *issue in issues) {
        if ([issue.issuestr isEqualToString:name]) {
            
            return issue.issuenum;
        }
    }
    
    return @"7";// 默认为7
}



// 返回当前彩种的 默认的 playType ，做为请求第一个参数
+ (NSString *)currentLotTypeDefaultPlayType
{
    XYLottery *lot = [XYTools lotteryWithName:[kUserDefaults objectForKey:k_CurrentLotteryName]];
    return lot.coinplays.firstObject.playtype;
}



// 返回当前彩种
+ (XYLottery *)currentLottery
{
    
   return [XYTools lotteryWithName:[kUserDefaults objectForKey:k_CurrentLotteryName]];
    
}




#pragma mark -- 这几个就行


// 返回当前彩种的playType ，做为请求第一个参数
+ (NSString *)currentPlayType
{
    return [kUserDefaults objectForKey:k_CurrentPlayType];
}

// 返回当前彩种Issuenum 做为请求第三个参数
+ (NSString *)currentIssuenum
{
    return [kUserDefaults objectForKey:k_CurrentIssuenum];
}

// 返回当前彩种的LotName ，做为请求第一个参数
+ (NSString *)currentLotName
{
    return [kUserDefaults objectForKey:k_CurrentLotteryName];
}

// 返回当前彩种的LotType ，做为请求第一个参数
+ (NSString *)currentLotType
{
    return [self currentLottery].lottype;
}

+ (void)setCurrentLotType:(NSString *)lottype
{
    [kUserDefaults setObject:lottype forKey:k_CurrentLotteryType]; // 双色球
}

+ (void)setCurrentIssuenum:(NSString *)issuenum
{
    [kUserDefaults setObject:issuenum forKey:k_CurrentIssuenum];    // 7期
}

+ (void)setCurrentPlayType:(NSString *)playType
{
    [kUserDefaults setObject:playType forKey:k_CurrentPlayType]; // 杀三码
}

+ (void)setCurrentLotName:(NSString *)playName
{
    // 由于 双色球 、 七乐彩 、 大乐透 默认playtype 为杀三码（1039），所以在保存时，默认保存为playtype 1039
    // 反之其他彩种在保存时，默认保存为playtype 1038（杀二码）
    
    if ([playName isEqualToString:@"双色球"] || [playName isEqualToString:@"七乐彩"] || [playName isEqualToString:@"大乐透"]) {
        [self setCurrentPlayType:@"1039"];
    }else
    {
        [self setCurrentPlayType:@"1038"];
    }
    [kUserDefaults setObject:playName forKey:k_CurrentLotteryName];
}

@end
