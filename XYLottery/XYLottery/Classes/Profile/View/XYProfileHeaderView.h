//
//  XYProfileHeaderView.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/10.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RechargeCallBack)();
typedef void(^RefreshCallBack)();

@interface XYProfileHeaderView : UIView

@property(nonatomic , strong) XYUser  *user;

@property(nonatomic , copy) RechargeCallBack rechargeClick;
@property(nonatomic , copy) RefreshCallBack refreshClick;




@end
