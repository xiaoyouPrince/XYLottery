//
//  ProfileViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "ProfileViewController.h"
#import "XYProfileHeaderView.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) XYProfileHeaderView *header;
@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic , strong) NSMutableArray<NSString *>  *titlesArray;


@end

@implementation ProfileViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = kGlobalBg;
    
    self.titlesArray = [NSMutableArray arrayWithObjects:@"签到获得金币",
                        @"分享短链接获得金币",
                        @"我的购买",
                        @"我的预测",
                        @"充值记录",
                        @"我的关注",
                        @"我的资料", nil];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Nav
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 根据登录与否展示对应的Page
    if ([XYAccountTool user]) {
        [self showProfileVC];
    }else
    {
        [self showLoginBtn];
    }
}

- (void)showLoginBtn
{
    UIButton *btn = [UIButton new];
    [btn setTitle:@"登录" forState:0];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.topMargin.mas_equalTo(100);
        make.height.mas_equalTo(100);
        
    }];
    
    [btn addTarget:self action:@selector(gotoLonginVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)gotoLonginVC
{
    XYLoginController *login = [XYLoginController new];
    [self.navigationController pushViewController:login animated:YES];
    login.loginSuccess = ^(BOOL isSuccess) {
        if (isSuccess) {
            [self showProfileVC];
        }
    };
}


- (void)showProfileVC
{
    // tableView
    UITableView *tableView = [UITableView new];
    tableView.frame = CGRectMake(0, 214, ScreenW, ScreenH - 260);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = [UIColor lightTextColor];
    
    // header
    XYProfileHeaderView *header = [[NSBundle mainBundle] loadNibNamed:@"XYProfileHeaderView" owner:nil options:nil].firstObject;
    header.frame = CGRectMake(0, 64, ScreenW, 150);
    [self.view addSubview:header];
    self.header = header;
    header.rechargeClick = ^{
        
    };
    header.refreshClick = ^{
        [self loadData];
    };
    
    [self loadData];
}


- (void)loadData
{
    /**
     
     获取账号信息的这里，只能有两个参数：userid + 对应的 session
     ...这里的请求参数需要单独写了...
     
     */
    
    
    XYRequestParam *params = [XYRequestParam new];
//    params.userid = @"629087";
    NSString *url = @"http://115.29.175.83/cpyc/getaccount.php";
    [XYHttpTool getWithURL:url params:params.keyValues success:^(NSDictionary * json) {
//        if (json[@"errorcode"] == 0) {
        
            // 请求成功，加载自己数据
//            XYUser *user = [XYUser userWithDict:json];
        
            XYUser *user = [XYUser objectWithKeyValues:json];
            [XYAccountTool saveUser:user];
            
            NSString *firstTitle = [self.titlesArray[0] stringByAppendingString:[XYAccountTool user].beatfcheck];
            [self.titlesArray replaceObjectAtIndex:0 withObject:firstTitle];
            NSString *secondTitle = [self.titlesArray[1] stringByAppendingString:[XYAccountTool user].beatftiny];
            [self.titlesArray replaceObjectAtIndex:1 withObject:secondTitle];
            
            
            self.header.user = user;
            [self.tableView reloadData];
//        }else
//        {
//            // 请求失败，加载登录页面数据
//            DLog(@"%@",@"失败");
//            
//        }
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.row == 0) {
        
        if ([XYAccountTool user]) {
            [self.titlesArray[indexPath.row] stringByAppendingString:[XYAccountTool user].beatfcheck];
        }
        
    }else if(indexPath.row == 1)
    {
        if ([XYAccountTool user]) {
            [self.titlesArray[indexPath.row] stringByAppendingString:[XYAccountTool user].beatftiny];
        }
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.titlesArray[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


@end
