//
//  XYIssuenumModel.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/3.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYIssueModel.h"

@implementation XYIssue


@end

@implementation XYIssueModel

- (NSDictionary *)objectClassInArray
{
    return @{@"issues" : [XYIssue class]};
}

@end
