//
//  XYRedResultView.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/9/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYOpenRedPackageView.h"

typedef void(^ResultViewCallBack)(void);

@interface XYRedResultView : UIView

@property(nonatomic , copy) ResultViewCallBack closeCallBack;

@end
