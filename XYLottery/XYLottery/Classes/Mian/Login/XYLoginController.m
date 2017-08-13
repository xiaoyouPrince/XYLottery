//
//  XYLoginController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/11.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYLoginController.h"
#import "XYRegisterController.h"
#import "XYForgetPassController.h"

@interface XYLoginController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;

@property (weak, nonatomic) IBOutlet UITextField *passTF;

@end

@implementation XYLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)loginClick:(UIButton *)sender {
    
    sender.enabled = NO;
    
    if (self.userNameTF.text.length && self.passTF.text.length) {
        
        // 登录请求
        // 成功回调，不成功提示失败
        XYRequestParam *params = [XYRequestParam new];
        params.userid = self.userNameTF.text;
        //    params.pass = self.passTF.text;
        [XYHttpTool postWithURL:@"login" params:params.keyValues success:^(id json) {
            
            sender.enabled = YES;
            
            if (/* DISABLES CODE */ (YES)) {
                if (self.loginSuccess) {
                    self.loginSuccess(YES);
                }
            
                [self.navigationController popViewControllerAnimated:YES];
                
            }else
            {
                [SVProgressHUD showWithStatus:@"账号密码错误请重试"];
            }
            
        } failure:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:@"网络错误，请稍后重试"];
            sender.enabled = YES;
        }];
        
    }else
    {
        [SVProgressHUD showErrorWithStatus:@"账号或密码为空"];
        sender.enabled = YES;
    }
    
}


- (IBAction)registerClick:(UIButton *)sender {
    
    XYRegisterController *registVC = [XYRegisterController new];
    [self.navigationController pushViewController:registVC animated:YES];
}


- (IBAction)forgotPassClick:(UIButton *)sender {
    
    XYForgetPassController *registVC = [XYForgetPassController new];
    [self.navigationController pushViewController:registVC animated:YES];
}


@end
