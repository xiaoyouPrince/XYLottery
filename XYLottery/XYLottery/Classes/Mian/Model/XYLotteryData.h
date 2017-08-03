//
//  XYLotteryData.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/3.
//  Copyright © 2017年 渠晓友. All rights reserved.
//
//  整个项目基础数据（从lotteryData.plist中读取）

#import <Foundation/Foundation.h>
#import "XYLottery.h"

@interface XYLotteryData : NSObject

@property(nonatomic , copy) NSString *invitedes;
@property(nonatomic , strong) NSNumber  *errorcode;
@property(nonatomic , copy) NSString *registurl;
@property(nonatomic , strong) NSNumber  *partnerId;
@property(nonatomic , strong) NSArray  *buycoinlist;  // 购买类型，模型尚未写
@property(nonatomic , strong) NSNumber  *version;
@property(nonatomic , strong) NSNumber  *regcoin;
@property(nonatomic , strong) NSNumber  *invitecoin;
@property(nonatomic , strong) NSNumber  *invitescore;
@property(nonatomic , strong) NSArray  *list;           // 彩票类型









@end
