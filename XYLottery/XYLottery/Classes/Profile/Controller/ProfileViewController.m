//
//  ProfileViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "ProfileViewController.h"
#import "XYProfileHeaderView.h"
#import "XYProfileVIewModel.h"
#import "XYBoughtViewController.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) XYProfileHeaderView *header;
@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic , strong) NSMutableArray<NSString *>  *titlesArray;
@property(nonatomic , strong) XYProfileVIewModel  *proVM;


@end

@implementation ProfileViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = kGlobalBg;
    self.proVM = [XYProfileVIewModel new];
    
    self.titlesArray = [NSMutableArray arrayWithObjects:@"签到获得金币",
                        @"分享短链接获得金币",
                        @"我的购买",
//                        @"我的预测",
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    // 根据登录与否展示对应的Page,不能每次都添加
//    if ([XYAccountTool user]) {
//        [self showProfileVC];
//    }else
//    {
//        [self showLoginBtn];
//    }
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD dismiss];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        // 拉取 签到信息
        [self.proVM checkinSuccess:^(BOOL success) {
            // 签到成功，这里主动刷新
            [self loadData];
        }];
    }
    
    if (indexPath.row == 1) {
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
        label.text = [NSString stringWithFormat:@"分享你的专属短连接可以获取金币，具体规则：\n 1.他人每次点击你可以获取1金币。\n 2.每日最多获取10金币 \n 3.重复刷新短连接算1次 \n\n 短连接:%@",[XYAccountTool user].tinyurl];
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
            [btn setTitle:@"复制链接" forState:0];
            
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
    
    
    if (indexPath.row == 2) {
        
        XYBoughtViewController *bought = [XYBoughtViewController new];
        [self.navigationController pushViewController:bought animated:YES];
    }
    
    
    if (indexPath.row == 5) {
        
        //我的资料
        [XYAccountTool deleteUser];
        
        // 移除所有View 并展示loginBtn
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self showLoginBtn];
    }
}


/**
 确认复制连接的按钮点击

 @param sender btn
 */
- (void)coverSureBtnClick:(UIButton *)sender
{
    [sender.superview.superview removeFromSuperview];
    
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经赋值到粘贴板" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [a show];
}



@end
