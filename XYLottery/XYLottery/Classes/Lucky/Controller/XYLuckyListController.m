//
//  XYLuckyListController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/9/4.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYLuckyListController.h"
#import "XYLucky.h"
#import "XYLuckyListDetailCell.h"

@interface XYLuckyListController ()

@property(nonatomic , strong) NSMutableArray <XYLucky *> *luckyDetailList;  ///< 所有用户手气数据


@end

@implementation XYLuckyListController


- (NSMutableArray *)luckyDetailList
{
    if (_luckyDetailList == nil) {
        _luckyDetailList = [NSMutableArray new];
    }
    return _luckyDetailList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.rowHeight = 80;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XYLuckyListDetailCell" bundle:nil] forCellReuseIdentifier:k_XYLuckyListDetailCell];
    
    
    /// 先加载数据
    [self loadLuckListData];
}

/**
 加载所有人的幸运列表
 */
- (void)loadLuckListData
{
    [SVProgressHUD show];
    
    NSString *url = @"http://115.29.175.83/cpyc/getcurredpacketsuser.php";
    [XYHttpTool getWithURL:url params:nil success:^(NSDictionary * json) {
        [SVProgressHUD dismiss];
        
        // 得到对应的当前获奖list
        NSMutableArray *arrayM = [NSMutableArray new];
        NSArray *array = [XYLucky objectArrayWithKeyValuesArray:json[@"list"]];
        for (XYLucky *luck in array) {
            [arrayM addObject:luck];
        }
        self.luckyDetailList = arrayM;
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请检查你的网络,并重试"];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.luckyDetailList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XYLuckyListDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:k_XYLuckyListDetailCell forIndexPath:indexPath];
//    cell.backgroundColor = indexPath.row % 2 ? [UIColor redColor] : [UIColor greenColor];
    cell.model = self.luckyDetailList[indexPath.row];
    return cell;
}




@end
