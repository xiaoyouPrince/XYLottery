//
//  XYSurveyListModel.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/2.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSurveyListModel : NSObject

//"calcid": "13822177",
//"username": "折算子",
//"isexpert": "1",
//"hitnum": "测7期对7期",
//"priceleve": "2",
//"status": 1,
//"userid": "15259",
//"playname": "杀二码",
//"playtype": "1038",
//"award": "杀2对2",
//"calc": "0,8",
//"viewnum": 12,
//"nextsid": "13846874",
//"nextplayname": "杀二码",
//"nextplaytype": "1038",
//"nextcalc": "该预测需要 2 金币才能查看，你确定需要查看此预测吗？",
//"nextpriceleve": "2",
//"nextstatus": 1,
//"nextplaydes": null

@property(nonatomic , copy) NSString *calcid;
@property(nonatomic , copy) NSString *username;
@property(nonatomic , copy) NSString *isexpert;
@property(nonatomic , copy) NSString *hitnum;
@property(nonatomic , copy) NSString *priceleve;
@property(nonatomic , strong) NSNumber *status; // 可能是int
@property(nonatomic , copy) NSString *userid;
@property(nonatomic , copy) NSString *playname;
@property(nonatomic , copy) NSString *award;
@property(nonatomic , copy) NSString *calc;
@property(nonatomic , strong) NSNumber *viewnum;
@property(nonatomic , copy) NSString *nextsid;
@property(nonatomic , copy) NSString *nextplayname;
@property(nonatomic , copy) NSString *nextplaytype;
@property(nonatomic , copy) NSString *nextcalc;
@property(nonatomic , copy) NSString *nextpriceleve;
@property(nonatomic , copy) NSString *nextstatus;
@property(nonatomic , copy) NSString *nextplaydes;

// 开奖历史里面的几个内容
@property(nonatomic , copy) NSString *kjissue;
@property(nonatomic , copy) NSString *kjdate;
@property(nonatomic , copy) NSString *kjnum;
@property(nonatomic , copy) NSString *kjxqurl;

// 中奖资讯里面几个内容
@property(nonatomic , copy) NSString *title;
@property(nonatomic , copy) NSString *pubdate;
@property(nonatomic , copy) NSString *pubaddr;
@property(nonatomic , copy) NSString *url;

// 走势图里面两个内容
@property(nonatomic , copy) NSString *trendname;
@property(nonatomic , copy) NSString *trendurl;











@property(nonatomic , assign) CGFloat cell_height;

@end
