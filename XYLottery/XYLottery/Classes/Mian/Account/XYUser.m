//
//  XYUser.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/11.
//  Copyright © 2017年 渠晓友. All rights reserved.
//
//  这里完全可以使用 KVO，runtime 来遍历 Ivar ，给对应的 Ivar 赋值，减少手动操作

#import "XYUser.h"

@implementation XYUser

/**
 *  创建一个单利对象
 */
+ (instancetype)user{
    static XYUser * tool = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    
    return tool;
}

// 保存用户信息
+ (instancetype)userWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // 防止崩溃
}

// 归档 && 解档
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self == [super init]) {
        
        self.contact = [decoder decodeObjectForKey:@"contact"];
        self.userid = [decoder decodeObjectForKey:@"userid"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.breif = [decoder decodeObjectForKey:@"breif"];
        self.registtime = [decoder decodeObjectForKey:@"registtime"];
        self.tinyurl = [decoder decodeObjectForKey:@"tinyurl"];
        self.beatfcheck = [decoder decodeObjectForKey:@"beatfcheck"];
        self.beatftiny = [decoder decodeObjectForKey:@"beatftiny"];
        self.beatfinvite = [decoder decodeObjectForKey:@"beatfinvite"];
        self.score = [decoder decodeIntegerForKey:@"score"];
        self.coin = [decoder decodeIntegerForKey:@"coin"];
        self.fans = [decoder decodeIntegerForKey:@"fans"];
        self.isexpert = [decoder decodeBoolForKey:@"isexpert"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.contact forKey:@"contact"];
    [encoder encodeObject:self.userid forKey:@"userid"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.breif forKey:@"breif"];
    [encoder encodeObject:self.registtime forKey:@"registtime"];
    [encoder encodeObject:self.tinyurl forKey:@"tinyurl"];
    [encoder encodeObject:self.beatfcheck forKey:@"beatfcheck"];
    [encoder encodeObject:self.beatftiny forKey:@"beatftiny"];
    [encoder encodeObject:self.beatfinvite forKey:@"beatfinvite"];
    [encoder encodeInteger:self.score forKey:@"score"];
    [encoder encodeInteger:self.coin forKey:@"coin"];
    [encoder encodeInteger:self.fans forKey:@"fans"];
    [encoder encodeBool:self.isexpert forKey:@"isexpert"];
}

@end
