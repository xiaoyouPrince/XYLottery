//
//  XYBoughtCacheTool.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/18.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYSurveyCache.h"

@interface XYBoughtCacheTool : NSObject

+ (void)add:(XYSurveyCache *)cache;

+ (NSArray <XYSurveyCache * >*)caches;


@end
