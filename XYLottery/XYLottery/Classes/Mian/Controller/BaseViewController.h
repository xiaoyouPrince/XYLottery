//
//  BaseViewController.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSurveyModel.h"
#import "XYSurveyListModel.h"

@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong) XYSurveyModel  *model;
@property(nonatomic , strong) NSArray<XYSurveyListModel *>  *list;
@property(nonatomic , weak) UITableView  *tableView;


- (void)reloadPageData;
- (void)hasChangeNavTitleLotType;

@end
