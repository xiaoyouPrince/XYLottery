//
//  BaseViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#define k_CurrentLotteryType @"currentLotteryType"

#import "BaseViewController.h"
#import "XYTitleButton.h"
#import "XYPopoverViewController.h"
#import "XYPopoverAnimator.h"

@interface BaseViewController ()

@property(nonatomic , weak)       XYTitleButton *titleButton; ///< title按钮
@property(nonatomic , strong)     XYPopoverAnimator *animator;
//@property(nonatomic , copy)       NSString *title;

@end

@implementation BaseViewController

- (XYPopoverAnimator *)animator
{
    if (_animator == nil) {
       
        _animator = [[XYPopoverAnimator alloc] initWithCallBack:^(BOOL dismisFinished) {
            [self titleButtonClick:self.titleButton];
        }];
    }
    return _animator;
}

- (void)loadView
{
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, ScreenW, ScreenH - 108);
    self.view.backgroundColor = kGlobalBg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    
    XYTitleButton *button = [[XYTitleButton alloc] init];
    button.frame = CGRectMake(0, 3, 120, 35);
    [button setTitle:@"双色球" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button;
    self.titleButton = button;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    // 这里就是记住当前的彩种
    NSString *lotType = [kUserDefaults objectForKey:k_CurrentLotteryType];
    if (lotType) {
        [self.titleButton setTitle:lotType forState:UIControlStateNormal];
    }else
    {
        [self.titleButton setTitle:@"双色球" forState:UIControlStateNormal];
    }
}

- (void)titleButtonClick:(XYTitleButton *)titleBtn
{
    titleBtn.selected = !titleBtn.selected;
    if (titleBtn.isSelected) {
        titleBtn.imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
    }else
    {
        titleBtn.imageView.transform = CGAffineTransformIdentity;
    }
    
    // 创建蒙版
    XYPopoverViewController *presentVC = [XYPopoverViewController new];
    presentVC.modalPresentationStyle = UIModalPresentationCustom;
    presentVC.transitioningDelegate = self.animator;
    [self presentViewController:presentVC animated:YES completion:nil];
    presentVC.callback = ^(NSString * chooseResult){
                
        [self.titleButton setTitle:chooseResult forState:UIControlStateNormal];
        
        // 保存用户选择
        [kUserDefaults setObject:chooseResult forKey:k_CurrentLotteryType];
        
        // 用户选择之后进行对应的类型请求数据
        XYRequestParam *params = [XYRequestParam new];
        params.playtype = @"1038";
        params.lottype = @"1005";
        params.issuenum = @"7";
        [XYHttpTool getWithURL:k_base_url params:params.keyValues success:^(id json) {
            
            NSLog(@"%@",json);
            
        } failure:^(NSError *error) {

            
            NSLog(@"%@",error);
            
        }];
        
    };
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


@end
