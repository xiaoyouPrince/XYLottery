//
//  XYLottery.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/3.
//  Copyright © 2017年 渠晓友. All rights reserved.
//
//  每种彩票的类型(从plist中读取)

#import <Foundation/Foundation.h>

@interface CoinPlay : NSObject

@property(nonatomic , copy) NSString *playtype;
@property(nonatomic , copy) NSString *playname;

@end


@interface XYLottery : NSObject

@property(nonatomic , copy) NSString *wfjsurl;
@property(nonatomic , copy) NSString *lottype;
@property(nonatomic , copy) NSString *lotname;
@property(nonatomic , copy) NSString *ctname;
@property(nonatomic , strong) NSArray<CoinPlay *>  *coinplays; // 玩法昵称和code

- (NSString *)playNameWithPlaytype:(NSString *)playType;

@end
