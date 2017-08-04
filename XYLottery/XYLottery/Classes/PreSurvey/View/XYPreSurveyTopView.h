//
//  XYPreSurveyTopView.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/2.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSurveyModel.h"

typedef void(^IssueunmCallBack)(NSString *);
typedef void(^PlayTypeCallBack)(NSString * , NSInteger);

@interface XYPreSurveyTopView : UIView

@property(nonatomic , copy) IssueunmCallBack issueCallBack;
@property(nonatomic , copy) PlayTypeCallBack playtypeCallBack;

@property(nonatomic , strong) XYSurveyModel * model;

@end
