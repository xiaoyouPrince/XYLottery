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
@property(nonatomic , copy) NSString *pass;
@property (nonatomic, copy) NSString *sessionid;

#pragma mark -- 用户注册
//pass		： 密码  	123456
//device	： 设备	1
//attentcode	：邀请码 （可以不填）
//mac		：mac地址	21BE3D7F-AFAF-4513-9577-7A005CDE8F77
//contact	：联系人邮箱	xiaoyouprince@163.com
//data		：数据？？	82549e24b41e2bd11482dd04f24bcd88
//breif		：简介 （没有写）
//username	： 用户名		èŠ±æ»¡æ¥¼
//channel	：渠道		iosiphone
//token	：令牌		10241545423773
@property(nonatomic , strong) NSNumber  *device;
@property(nonatomic , copy) NSString *attentcode;
@property(nonatomic , copy) NSString *mac;
@property(nonatomic , copy) NSString *contact;
@property(nonatomic , copy) NSString *channel;
@property(nonatomic , copy) NSString *username;
@property(nonatomic , copy) NSString *breif;
@property(nonatomic , copy) NSString *data;











@end
