//
//  XYCurSurveyCell.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/8.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPreSurveyCell.h"

#define k_XYCurSurveyCellID @"XYCurSurveyCell"

@interface XYCurSurveyCell : XYPreSurveyCell

@property(nonatomic , strong) XYSurveyListModel  *cur_model;

@end
