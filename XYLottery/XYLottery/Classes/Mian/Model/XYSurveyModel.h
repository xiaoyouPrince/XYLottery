//
//  XYSurveyModel.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/2.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYSurveyListModel.h"

@interface XYSurveyModel : NSObject

// http://115.29.175.83/cpyc/getprecalc.php?lastid=-1&playtype=1038&lottype=1005&ctype=1&iosversion=1.4.5&issuenum=7&token=6f56e55b71ba520cddc64918595d0e72&key=1501660575

//"errorcode": 0,
//"secttime": 0,
//"message": "欢迎来围观专家预测比赛，新注册用户赠送8金币，确定注册吗？",
//"lottype": "1005",
//"kjissue": "2017206",
//"kjnum": "3,7,5",
//"nextissue": "2017207",
//"lastid": "13842576",
//"hasnextpage": 0,

@property(nonatomic , copy) NSString *message; ///< 得到的信息
@property(nonatomic , copy) NSString *kjissue; ///< 开奖期数
@property(nonatomic , copy) NSString *lottype; ///< 彩票类型
@property(nonatomic , copy) NSString *kjnum;   ///< 开奖号码
@property(nonatomic , copy) NSString *lastid;  ///< 上次id
@property(nonatomic , copy) NSString *nextissue; ///< 下期开奖期数
// 预测第一个cell用的
@property(nonatomic , copy) NSString *lineone;   ///< 第一行（实际第二行）
@property(nonatomic , copy) NSString *linetwo;   ///< 第2行（实际第1行




@property(nonatomic , strong) NSArray<XYSurveyListModel*>  *list;


/// 保存对应的 playtype_index
@property(nonatomic , assign) NSInteger playType_index;


@end
