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
#import "XYBoughtCacheTool.h"

#define k_cur_topViewH 80


@interface CurSurveyController ()

@property (nonatomic , weak) XYCurSurveyTopView *top;

@property(nonatomic,assign) NSInteger self_playtypeIndex;

@end

@implementation CurSurveyController

static XYSurveyListModel *model; // 要买的那个list 的model。给cache赋值


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
    
    cell.buyCallBack = ^(XYSurveyListModel *cur_model){

        // 验证是否登录
        if ([XYAccountTool user]) {

            // 提示要不要进行购买
            [self showTipView:cur_model];

        }else
        {
            // 去登录
            XYLoginController *login = [XYLoginController new];
            [self.navigationController pushViewController:login animated:YES];
            login.loginSuccess = ^(BOOL isSuccess) {

                // 成功后在提示要不要进行购买。。。
                [self showTipView:cur_model];
            };
        }
        
    };
    
    return cell;
}



- (void)showTipView:(XYSurveyListModel *)cur_model
{
    
    model = cur_model;
    
    // 分享链接赚钱
    UIButton *coverBtn = [[UIButton alloc]initWithFrame:self.view.bounds];
    coverBtn.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.view addSubview:coverBtn];
    [coverBtn addTarget:coverBtn action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.center = self.view.center;
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(10, 10, ScreenW - 20, 100);
    label.text = [NSString stringWithFormat:@"    专家不保证百分百准确 。本预测需要 %@ 金币才能查看，你确定需要查看此预测吗？",cur_model.priceleve];
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 0;
    label.textColor = [UIColor blackColor];

    [bgView addSubview:label];
    [coverBtn addSubview:bgView];

    for (int i = 0 ; i < 2; i++) {
        UIButton *btn = [UIButton new];
        [btn setBackgroundColor:[UIColor greenColor]];
        btn.frame = CGRectMake(30 + (WIDTH(label) / 2) * i,MaxY(label) + 5 , 100, 30);
        [bgView addSubview:btn];
        [btn setTitle:@"确定" forState:0];

        if (i == 1) {
            [btn setTitle:@"取消" forState:0];
            btn.frame = CGRectMake(WIDTH(label) +10 - 100 - 20,MaxY(label) + 5 , 100, 30);
            [btn addTarget:btn.superview.superview action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
        }else
        {
            [btn addTarget:self action:@selector(coverSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    
    }
    
}

- (void)coverSureBtnClick:(UIButton *)sender
{
    // 保存对应的 surveyCache
    
    XYSurveyCache *cache = [XYSurveyCache new];
    
    // 时间的kit
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *currentDateStr = [fmt stringFromDate:date];
    
    cache.createtime = currentDateStr;
    cache.coin = model.priceleve;
    cache.expertid = model.userid;   //@"188322";
    cache.expertname = model.username;   //@"哈师大打包";
//    cache.playtype = [XYTools currentPlayType];
    cache.lotname = [XYTools currentLotName];
    
    cache.playtype = [[XYTools currentLottery] playNameWithPlaytype:[XYTools currentPlayType]];
    
    cache.calcdata = @"08,06,09";
    
    [XYBoughtCacheTool add:cache];

    DLog(@"---count = %zd",[XYBoughtCacheTool caches].count);
    
    [sender.superview.superview removeFromSuperview];
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
