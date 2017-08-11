//
//  XYLoginController.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/11.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginSuccessCallBack)(BOOL isSuccess);

@interface XYLoginController : UIViewController

@property(nonatomic , copy) LoginSuccessCallBack loginSuccess;


@end
