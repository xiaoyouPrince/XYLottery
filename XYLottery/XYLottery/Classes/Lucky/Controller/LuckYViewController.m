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
    
    
    
    

    /**
     基本模仿，主要有变化
     
     正点的时候下红包雨，，，来正经的来展示，，，
     
     用户点击判断是不是正确的时间，如果是就直接调接口强，不是就提示原来页面

     @return <#return value description#>
     */
    
}


- (void)loadLuckData
{
    [SVProgressHUD show];
    
    NSString *url = @"http://115.29.175.83/cpyc/getredpackets.php";
    [XYHttpTool getWithURL:url params:nil success:^(NSDictionary * json) {
        [SVProgressHUD dismiss];
        
        // 得到对应的当前获奖list
        NSMutableArray *array = [NSMutableArray new];
        int i = 0;
        for (XYLucky *lucky in json[@"list"]) {
//            lucky = [XYLucky objectWithKeyValues:json[@"list"][i]];
            
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请检查你的网络,并重试"];
    }];
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
