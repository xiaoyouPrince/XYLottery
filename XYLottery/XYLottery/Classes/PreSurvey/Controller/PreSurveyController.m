//
//  PreSurveyController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//


#define topViewH 100

#import "PreSurveyController.h"
#import "XYPreSurveyTopView.h"
#import "XYPreSurveyCell.h"

@interface PreSurveyController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , weak) XYPreSurveyTopView *top;

@end

@implementation PreSurveyController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加topView
    XYPreSurveyTopView *top = [[NSBundle mainBundle] loadNibNamed:@"XYPreSurveyTopView" owner:nil options:nil].lastObject;
    self.top = top;
    top.frame = CGRectMake(0, 64, ScreenW, 100);
    [self.view addSubview:top];
    top.issueCallBack = ^(NSString *issuenum) {
        
        // 根据这个请求并刷新数据
        [self loadDataWithPlayType:[XYTools currentPlayType] lotType:[XYTools currentLotType] issuenum:[XYTools currentIssuenum] playTypeIndex:0];
        
    };
    top.playtypeCallBack = ^(NSString *playtype , NSInteger playtype_index) {
        // 根据这个请求并刷新数据
        [self loadDataWithPlayType:[XYTools currentPlayType] lotType:[XYTools currentLotType] issuenum:[XYTools currentIssuenum] playTypeIndex:playtype_index];
    };
    
    // 设置自己tableView
    self.tableView.frame = CGRectMake(0, 100, ScreenW, ScreenH - 100);
    [self.tableView registerNib:[UINib nibWithNibName:@"XYPreSurveyCell" bundle:nil] forCellReuseIdentifier:k_PreSurveyCelID];
}

-(void)viewWillAppear:(BOOL)animated
{

//    [self reloadPageData]; 
    
    [super viewWillAppear:animated];
}


- (void)loadDataWithPlayType:(NSString *)playTpye lotType:(NSString *)lotType issuenum:(NSString *)issuenum playTypeIndex:(NSInteger)playType_index
{
    
    XYRequestParam *params = [XYRequestParam new];
    params.playtype = playTpye;
    params.lottype = lotType;
    params.issuenum = issuenum;
    [XYHttpTool getWithURL:k_base_url params:params.keyValues success:^(NSDictionary* json) {
        
        NSLog(@"%@",json);
        
        self.model = [XYSurveyModel objectWithKeyValues:json];
        self.model.playType_index = playType_index;  // 这里保存一下对应的playTypeIndex，能刷新之后保留在原来位置
        self.list = [XYSurveyListModel objectArrayWithKeyValuesArray:json[@"list"]];
        
        [self reloadPageData];
        
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellID = @"cellID";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"---%zd----",indexPath.row];
    
    XYPreSurveyCell *cell = [tableView dequeueReusableCellWithIdentifier:k_PreSurveyCelID];
    
    cell.model = self.list[indexPath.row];
    
    return cell;
}



@end
