//
//  BaseViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//


#import "BaseViewController.h"
#import "XYTitleButton.h"
#import "XYPopoverViewController.h"
#import "XYPopoverAnimator.h"

@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>

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
    
//    self.view.frame = CGRectMake(0, 0, ScreenW, ScreenH - 108);
    self.view.backgroundColor = kGlobalBg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Nav
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    
    XYTitleButton *button = [[XYTitleButton alloc] init];
    button.frame = CGRectMake(0, 3, 120, 35);
    [button setTitle:@"双色球" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button;
    self.titleButton = button;
    
    // tableView
    UITableView *tableView = [UITableView new];
    tableView.frame = CGRectMake(0, 100, ScreenW, ScreenH - 108 - 100);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
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
    
    // 每次展示根据当前类型进行请求最新数据
    [self loadDataWithPlayType:@"1038" lotName:lotType issuenum:@"7"];
    
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
        [self loadDataWithPlayType:@"1038" lotName:chooseResult issuenum:@"7"];
        
    };
 
}

- (void)loadDataWithPlayType:(NSString *)playTpye lotName:(NSString *)lotName issuenum:(NSString *)issuenum
{
    
    NSString *lotType = nil;
    if ([lotName isEqualToString:@"双色球"]) {
        lotType = @"1001";
    }else if ([lotName isEqualToString:@"福彩3D"]) {
        lotType = @"1002";
    }else if ([lotName isEqualToString:@"七乐彩"]) {
        lotType = @"1003";
    }else if ([lotName isEqualToString:@"七星彩"]) {
        lotType = @"1004";
    }else if ([lotName isEqualToString:@"排列三"]) {
        lotType = @"1005";
    }else if ([lotName isEqualToString:@"排列五"]) {
        lotType = @"1006";
    }else if ([lotName isEqualToString:@"大乐透"]) {
        lotType = @"1007";
    }
    
    
    XYRequestParam *params = [XYRequestParam new];
    params.playtype = playTpye;
    params.lottype = lotType;
    params.issuenum = issuenum;
    [XYHttpTool getWithURL:k_base_url params:params.keyValues success:^(NSDictionary* json) {
        
        NSLog(@"%@",json);
        
        self.model = [XYSurveyModel objectWithKeyValues:json];
        self.list = [XYSurveyListModel objectArrayWithKeyValuesArray:json[@"list"]];
        
        //            NSLog(@"%@",self.list);
        
        
        [self reloadPageData];
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"%@",error);
        
    }];
}

- (void)reloadPageData
{
//    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"---%zd----",indexPath.row];
    
    return cell;
}

@end
