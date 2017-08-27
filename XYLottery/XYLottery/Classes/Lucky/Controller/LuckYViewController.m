//
//  LuckYViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//



//  这几天暂时停网了，所以停一下开发，相信很快就可以继续开始了，哈哈  2017年08月26日23:44:03



#import "LuckYViewController.h"
#import "XYLucky.h"

@interface LuckYViewController ()

@property(nonatomic , strong) NSMutableArray <XYLucky *> *luckyList;


@end

@implementation LuckYViewController

- (NSMutableArray *)luckyList
{
    if (_luckyList == nil) {
        _luckyList = [NSMutableArray new];
    }
    return _luckyList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self loadLuckData];
    
    
    

    /**
     基本模仿，主要有变化
     
     正点的时候下红包雨，，，来正经的来展示，，，
     
     用户点击判断是不是正确的时间，如果是就直接调接口强，不是就提示原来页面

     @return <#return value description#>
     */
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadLuckData];
}


- (void)loadLuckData
{
    [SVProgressHUD show];
    
    NSString *url = @"http://115.29.175.83/cpyc/getredpackets.php";
    [XYHttpTool getWithURL:url params:nil success:^(NSDictionary * json) {
        [SVProgressHUD dismiss];
        
        // 得到对应的当前获奖list
        NSMutableArray *arrayM = [NSMutableArray new];
        NSArray *array = [XYLucky objectArrayWithKeyValuesArray:json[@"list"]];
        for (XYLucky *luck in array) {
            [arrayM addObject:luck];
        }
        self.luckyList = arrayM;
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请检查你的网络,并重试"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.luckyList.count;
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
