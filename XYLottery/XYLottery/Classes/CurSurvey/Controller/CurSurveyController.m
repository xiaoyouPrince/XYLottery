//
//  CurSurveyController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "CurSurveyController.h"
#import "XYCurSurveyTopView.h"
#import "XYCurSurveyCell.h"

#define k_cur_topViewH 80


@interface CurSurveyController ()

@property (nonatomic , weak) XYCurSurveyTopView *top;

@property(nonatomic,assign) NSInteger self_playtypeIndex;

@end

@implementation CurSurveyController


// 这里是重写父类的方法，用于得到修改彩票类型的通知
- (void)hasChangeNavTitleLotType
{
    [super hasChangeNavTitleLotType];
    
    self.self_playtypeIndex = 0;
}

- (void)loadDataWithPlayType:(NSString *)playTpye lotName:(NSString *)lotName issuenum:(NSString *)issuenum
{   // 纯粹是为了重写父类的方法，能够直接调用子类方法，拉取本页面数据（紧修改url）
    
    NSString *lotType = [XYTools lotteryWithName:lotName].lottype;
    
    XYRequestParam *params = [XYRequestParam new];
    params.playtype = playTpye;
    params.lottype = lotType;
    params.issuenum = issuenum;
    [XYHttpTool getWithURL:k_getcur_url params:params.keyValues success:^(NSDictionary* json) {
        
        NSLog(@"%@",json);
        
        self.model = [XYSurveyModel objectWithKeyValues:json];
        self.list = [XYSurveyListModel objectArrayWithKeyValuesArray:json[@"list"]];

        [self reloadPageData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加topView
    XYCurSurveyTopView *top = [[NSBundle mainBundle] loadNibNamed:@"XYCurSurveyTopView" owner:nil options:nil].lastObject;
    self.top = top;
    top.frame = CGRectMake(0, 64, ScreenW, k_cur_topViewH);
    [self.view addSubview:top];
    top.issueCallBack = ^(NSString *issuenum) {
        // 直接下拉一下
        [self.tableView.mj_header beginRefreshing];
    };
    top.playtypeCallBack = ^(NSString *playtype , NSInteger playtype_index) {
        
        // 保存自己内部的 playtype_index
        self.self_playtypeIndex = playtype_index;
        
        // 直接下拉一下
        [self.tableView.mj_header beginRefreshing];
    };
    
    // 设置自己tableView
    self.tableView.frame = CGRectMake(0, k_cur_topViewH, ScreenW, ScreenH - k_cur_topViewH);
    [self.tableView registerNib:[UINib nibWithNibName:@"XYCurSurveyCell" bundle:nil] forCellReuseIdentifier:k_XYCurSurveyCellID];
    
    
    // 添加刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 根据这个请求并刷新数据
        [self loadDataWithPlayType:[XYTools currentPlayType] lotType:[XYTools currentLotType] issuenum:[XYTools currentIssuenum] playTypeIndex:self.self_playtypeIndex];
        
        [self.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        // 根据这个请求并刷新数据
        [self loadDataWithPlayType:[XYTools currentPlayType] lotType:[XYTools currentLotType] issuenum:[XYTools currentIssuenum] playTypeIndex:self.self_playtypeIndex];
        
        [self.tableView.mj_footer endRefreshing];
    }];
}


- (void)loadDataWithPlayType:(NSString *)playTpye lotType:(NSString *)lotType issuenum:(NSString *)issuenum playTypeIndex:(NSInteger)playType_index
{
    
    // 展示HUD
    [SVProgressHUD showWithStatus:@"loading..."];
    
    XYRequestParam *params = [XYRequestParam new];
    params.playtype = playTpye;
    params.lottype = lotType;
    params.issuenum = issuenum;
    [XYHttpTool getWithURL:k_getcur_url params:params.keyValues success:^(NSDictionary* json) {
        
        NSLog(@"%@",json);
        
        self.model = [XYSurveyModel objectWithKeyValues:json];
        self.model.playType_index = playType_index;  // 这里保存一下对应的playTypeIndex，能刷新之后保留在原来位置
        self.list = [XYSurveyListModel objectArrayWithKeyValuesArray:json[@"list"]];
        
        [self reloadPageData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}



-(void)reloadPageData
{
    [super reloadPageData];
    
    self.top.model = self.model;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSurveyListModel *model = self.list[indexPath.row];
    return model.cell_height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCurSurveyCell *cell = [tableView dequeueReusableCellWithIdentifier:k_XYCurSurveyCellID];
    
    cell.cur_model = self.list[indexPath.row];
    
    return cell;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellID = @"cellID";
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//
//    cell.textLabel.text = [NSString stringWithFormat:@"---%zd--hahh--",indexPath.row];
//    
//    return cell;
//}

@end
