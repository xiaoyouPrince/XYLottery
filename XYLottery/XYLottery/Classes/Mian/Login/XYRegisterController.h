//
//  XYRegisterController.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/13.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYCustomBackButtonViewController.h"

typedef void(^RegistSuccessCallBack)(BOOL isSuccess);

@interface XYRegisterController : UIViewController

@property(nonatomic , copy) RegistSuccessCallBack registSuccess;


@end
