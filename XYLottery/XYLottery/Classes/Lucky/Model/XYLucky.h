//
//  XYLucky.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/22.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYLucky : NSObject

@property(nonatomic , copy) NSString *type;
@property(nonatomic , copy) NSString *username;
@property(nonatomic , copy) NSString *coin;
@property(nonatomic , copy) NSString *createtime;  // 创建时间


//{
//    "errorcode": 0,
//    "message": "",
//    "list": [
//             {
//                 "type": "2",
//                 "username": "user625774",
//                 "coin": "1"
//             },
//             {
//                 "type": "3",
//                 "username": "韩甲富",
//                 "coin": "1"
//             },
//             {
//                 "type": "3",
//                 "username": "往事如烟",
//                 "coin": "3"
//             },
//             {
//                 "type": "3",
//                 "username": "丹宝",
//                 "coin": "1"
//             },
//             {
//                 "type": "3",
//                 "username": "行星",
//                 "coin": "7"
//             }
//             ],
//    "nexttimedes": "下一波金币红包15:00分开抢！",
//    "timeh": "14:00"
//}

/// 这个是详情中的，多了一个时间字段
//{
//    "type": "2",
//    "username": "忠",
//    "coin": "6",
//    "createtime": "2017-09-04 10:00:03"
//},

@end
