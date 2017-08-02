//
//  BaseViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "BaseViewController.h"
#import "XYTitleButton.h"

@interface BaseViewController ()

@property(nonatomic , weak)       XYTitleButton *titleButton; ///< title按钮
//@property(nonatomic , strong)     NSArray  *dataArray;
//@property(nonatomic , copy)       NSString *title;

@end

@implementation BaseViewController

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
    
    //    if ([XYAccountTool account].name) {
    //        [button setTitle:[XYAccountTool account].name forState:UIControlStateNormal];
    //    }else
    //    {
    [self.titleButton setTitle:@"双色球" forState:UIControlStateNormal];
    //    }
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
    
    
    // 蒙版点击之后进行对应的类型请求数据
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
