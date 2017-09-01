//
//  XYOpenRedPackageView.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/9/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYOpenRedPackageView;
typedef void(^OpenCallBack)(XYOpenRedPackageView *openView);

@interface XYOpenRedPackageView : UIView

@property(nonatomic , copy) OpenCallBack callBack;

@end
