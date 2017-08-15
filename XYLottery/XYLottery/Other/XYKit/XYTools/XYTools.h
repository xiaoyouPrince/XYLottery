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
#import "XYIssueModel.h"


@interface XYTools : NSObject

@property(nonatomic , strong) XYLotteryData  *lotteryData;

+ (XYLotteryData *)lotteryData;
+ (XYIssueModel *)issueModel;
+ (XYLottery *)lotteryWithName:(NSString *)lotName;
+ (NSString *)issuenumWithName:(NSString *)name;
+ (XYLottery *)currentLottery;

+ (NSString *)currentPlayType;
+ (NSString *)currentIssuenum;
+ (NSString *)currentLotType;
+ (NSString *)currentLotName;

+ (void)setCurrentPlayType:(NSString *)playType;
+ (void)setCurrentIssuenum:(NSString *)issuenum;
+ (void)setCurrentLotType:(NSString *)lottype;
+ (void)setCurrentLotName:(NSString *)playName;


@end
