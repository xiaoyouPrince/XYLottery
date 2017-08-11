//
//  XYRequestParam.h
//  BBAngel
//
//  Created by Xiaoyou on 16/8/27.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYRequestParam : NSObject

#pragma mark -- 基本参数
@property (nonatomic, copy) NSString *lastid;  ///< 上次id 缺省-1
@property (nonatomic, copy) NSString *playtype; ///< 玩法类型 ***
@property (nonatomic, copy) NSString *lottype; ///< 彩票类型 1001 - 1007
@property (nonatomic, copy) NSString *ctype;    ///< 不太知道 缺省1
@property (nonatomic, copy) NSString *iosversion;   ///< iOS版本 缺省1.4.5
@property (nonatomic, copy) NSString *issuenum; ///< 按第几期排列  **
#pragma mark -- token
@property (nonatomic, copy) NSString *token;    ///< 认证token，令牌
@property(nonatomic , copy) NSString *key;  ///< 当前时间戳
#pragma mark -- 测讯的curindex
@property(nonatomic , assign) NSInteger curindex;  ///< 测讯当前index

#pragma mark -- 用户请求主页
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *sessionid;

@end
