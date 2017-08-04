//
//  XYIssuenumModel.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/3.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYIssue : NSObject

@property(nonatomic , copy) NSString *issuenum;
@property(nonatomic , copy) NSString *issuestr;

@end

@interface XYIssueModel : NSObject

@property(nonatomic , strong) NSArray<XYIssue*>  *issues;


@end
