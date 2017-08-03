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

@end
