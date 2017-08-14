//
//  XYRegisterController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/13.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYRegisterController.h"

@interface XYRegisterController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;
@property (weak, nonatomic) IBOutlet UITextField *contactTF;
@property (weak, nonatomic) IBOutlet UITextField *attentcodeTF;

@end

@implementation XYRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
}

- (IBAction)registerBtnClick:(UIButton *)sender {
    
    NSUInteger userNameL = self.userNameTF.text.length;
    NSUInteger passL = self.passTF.text.length;
    NSUInteger contactL = self.contactTF.text.length;
    
    if (!(userNameL && passL && contactL)) {
        [SVProgressHUD showErrorWithStatus:@"请正确输入必填项"];
        return;
    }
    
    
#define k_registerUrl @"http://115.29.175.83/cpyc/registnew.php"
    
    XYRequestParam *params = [XYRequestParam new];
    params.username = self.userNameTF.text;
    params.pass = self.passTF.text;
    params.contact = self.contactTF.text;
    params.attentcode = self.attentcodeTF.text;
    params.token = @"10241983590665";
    [XYHttpTool postWithURL:k_registerUrl params:params.keyValues success:^(NSDictionary * json) {
        
        DLog(@"%@",json);
        
        
        if ([json[@"errorcode"] integerValue]) {
            // 有错误的时候，直接进去
            
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            // 直接退出到我的页面，并刷新对应数据；；
            if (self.registSuccess) {
                self.registSuccess(YES);
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }

    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        
    }];
    
}

@end
