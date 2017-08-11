//
//  XYLoginController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/11.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYLoginController.h"

@interface XYLoginController ()

@end

@implementation XYLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)loginClick:(id)sender {
    
    // 登录请求
    
    
    if (self.loginSuccess) {
        self.loginSuccess(YES);
    }
    
}




@end
