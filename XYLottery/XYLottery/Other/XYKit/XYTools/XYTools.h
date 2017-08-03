//
//  XYTools.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/3.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYLottery.h"
#import "XYLotteryData.h"


@interface XYTools : NSObject

@property(nonatomic , strong) XYLotteryData  *lotteryData;

+ (XYLotteryData *)lotteryData;
+ (XYLottery *)lotteryWithName:(NSString *)lotName;


@end
