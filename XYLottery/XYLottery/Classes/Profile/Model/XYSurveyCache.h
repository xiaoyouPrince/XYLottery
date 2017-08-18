//
//  XYSurveyCache.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/18.
//  Copyright © 2017年 渠晓友. All rights reserved.
//
//  这个一个用户购买的缓存数据//  这里是用户购买预测的缓存----不是本页显示的list的model
//  有几个固定数据，其他只需要赋值几个就行。

#import <Foundation/Foundation.h>
#import "XYSurveyListModel.h"

@interface XYSurveyCache : NSObject

@property(nonatomic , strong) XYSurveyListModel *model;

//{
//    "createtime": "2017-08-16 17:56:28",
//    "status": "1",
//    "coin": "1",
//    "expertid": "15978",
//    "expertname": "\u98ce\u96ea\u591c\u5f52\u4eba",
//    "playtype": "\u84dd\u7403\u5b9a\u4e94\u80c6",
//    "lotname": "\u53cc\u8272\u7403",
//    "calcdata": "03,06,09,14,15"
//}

@property(nonatomic , copy) NSString *createtime;
@property(nonatomic , copy) NSString *status;
@property(nonatomic , copy) NSString *coin;
@property(nonatomic , copy) NSString *expertid;
@property(nonatomic , copy) NSString *expertname;
@property(nonatomic , copy) NSString *playtype;
@property(nonatomic , copy) NSString *lotname;
@property(nonatomic , copy) NSString *calcdata;
//@property(nonatomic , copy) NSString *createtime;

@end
