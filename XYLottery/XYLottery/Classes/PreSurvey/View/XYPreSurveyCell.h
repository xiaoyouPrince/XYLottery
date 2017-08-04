//
//  XYPreSurveyCell.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/3.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#define k_PreSurveyCelID @"PreSurveyCel"

#import <UIKit/UIKit.h>
#import "XYPreSurveyModel.h"

@interface XYPreSurveyCell : UITableViewCell

@property(nonatomic , strong) XYPreSurveyModel  *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
