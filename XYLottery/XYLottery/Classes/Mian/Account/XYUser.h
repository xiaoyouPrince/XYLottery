//
//  XYUser.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/11.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYUser : NSObject<NSCoding>

//{
//    "errorcode": 0,
//    "contact": "journey@qq.com",
//    "userid": "629087",
//    "username": "哦了也快我",
//    "breif": "",
//    "score": "0",
//    "coin": "13",
//    "fans": "1",
//    "isexpert": "0",
//    "registtime": "20170809102904",
//    "tinyurl": "http://t.cn/R9H4wUK",
//    "beatfcheck": "(共获2金币,打败89.63%用户)",
//    "beatftiny": "(共获3金币,打败97.51%用户)",
//    "beatfinvite": "(共获0金币,打败0%用户)",
//    "medalindex": 1,
//    "voucher": "0",
//    "yongjin": 0,
//    "agenttinyurl": null,
//    "agentpicpath": null,
//    "isshowadv": 1
//}


@property(nonatomic , copy) NSString *contact;
@property(nonatomic , copy) NSString *userid;
@property(nonatomic , copy) NSString *username;
@property(nonatomic , copy) NSString *breif;
@property(nonatomic , assign) NSInteger score;
@property(nonatomic , assign) NSInteger coin;
@property(nonatomic , assign) NSInteger fans;
@property(nonatomic , assign) BOOL isexpert;
@property(nonatomic , copy) NSString *registtime;
@property(nonatomic , copy) NSString *tinyurl;
@property(nonatomic , copy) NSString *beatfcheck;
@property(nonatomic , copy) NSString *beatftiny;
@property(nonatomic , copy) NSString *beatfinvite;



/**
 *  创建一个单利对象
 */
+ (instancetype)user;
/**
 *  保存用户信息
 */
+ (instancetype)userWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
