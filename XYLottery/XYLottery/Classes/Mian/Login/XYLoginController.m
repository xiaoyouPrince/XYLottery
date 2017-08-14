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
    
    self.navigationItem.title = @"登录";
    
    
}

- (IBAction)loginClick:(UIButton *)sender {
    
    sender.enabled = NO;
    [SVProgressHUD dismiss];
    
    if (self.userNameTF.text.length && self.passTF.text.length) {
        
        // 登录请求
        // 成功回调，不成功提示失败
        XYRequestParam *params = [XYRequestParam new];
        params.userid = self.userNameTF.text;
        params.pass = self.passTF.text;
        
#define k_loginUrl @"http://115.29.175.83/cpyc/login.php"
        
        [XYHttpTool postWithURL:k_loginUrl params:params.keyValues success:^(NSDictionary * json) {
            
            sender.enabled = YES;
            
            DLog(@"%@",json);
            
            if ([json[@"errorcode"] integerValue] == 0) {
                if (self.loginSuccess) {
                    self.loginSuccess(YES);
                }
            
                [SVProgressHUD showSuccessWithStatus:json[@"message"]];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else
            {
                [SVProgressHUD showErrorWithStatus:json[@"message"]];
                
                
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
    [SVProgressHUD dismiss];

    XYRegisterController *registVC = [XYRegisterController new];
    [self.navigationController pushViewController:registVC animated:YES];
    registVC.registSuccess = ^(BOOL isSuccess) {
        
        // 实际上这里是假的注册成功，只需要给用户一个反馈，，，
        // 返回对应的页面去刷新吧，，，，这里登录一个新注册号码
        
        XYRequestParam *params = [XYRequestParam new];
        params.userid = @"633441";
        params.pass = @"123456";
        
#define k_loginUrl @"http://115.29.175.83/cpyc/login.php"
        
        [XYHttpTool postWithURL:k_loginUrl params:params.keyValues success:^(NSDictionary * json) {
            
            sender.enabled = YES;
            
            DLog(@"%@",json);
            
            if (self.loginSuccess) {
                self.loginSuccess(YES);
            }

        } failure:^(NSError *error) {
        }];

    };
}


- (IBAction)forgotPassClick:(UIButton *)sender {
    [SVProgressHUD dismiss];

    XYForgetPassController *registVC = [XYForgetPassController new];
    [self.navigationController pushViewController:registVC animated:YES];
}


@end
