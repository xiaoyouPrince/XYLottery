//
//  XYSurveyModel.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/2.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYSurveyModel.h"

@implementation XYSurveyModel

- (NSDictionary *)objectClassInArray
{
    return @{@"list" : [XYSurveyListModel class]};
}

- (NSInteger)playType_index
{
    if (_playType_index == 0) {
        
        return _playType_index;
    }
    return _playType_index;
}
@end
