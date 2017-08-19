//
//  XYLottery.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/3.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYLottery.h"

@implementation CoinPlay


@end

@implementation XYLottery

- (NSDictionary*)objectClassInArray
{
    return @{@"coinplays" : [CoinPlay class]};
}

- (NSString *)playNameWithPlaytype:(NSString *)playType{
    
    for (CoinPlay *coinplay in self.coinplays) {
        if ([coinplay.playtype isEqualToString:playType]) {
            return coinplay.playname;
        }
    }
    
    return @"1039";
}
@end
