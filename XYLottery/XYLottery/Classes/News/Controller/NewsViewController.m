//
//  NewsViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "NewsViewController.h"
#import "XYScrollHeaderView.h"
#import "XYNewsZuheFirstCell.h"
#import "XYPreSurveyCell.h"
#import "XYNewsHistoryCell.h"

typedef NS_ENUM(NSUInteger, XYNewsType) {
    XYNewsTypeZuhe = 0,  ///< 大奖专家组合
    XYNewsTypeHistory,  ///< 开奖历史
    XYNewsTypeNews,     ///< 中奖资讯
    XYNewsTypeTrand,    ///< 走势图
    XYNewsTypeMethod    ///< 购彩技巧
};


@interface NewsViewController ()

@property(nonatomic,assign) XYNewsType newsType;


@end

@implementation NewsViewController

// 这里是重写父类的方法，用于得到修改彩票类型的通知
- (void)hasChangeNavTitleLotType
{
    [super hasChangeNavTitleLotType];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 防止headerView
    [self setupHeaderView];
    
    // 设置tableView的frame
    // 添加刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self reloadPageData];
        [self.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        [self.tableView.mj_footer endRefreshing];
    }];
    
}

- (void)setupHeaderView{
    
    XYScrollHeaderView *header = [[XYScrollHeaderView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 30)];
    [self.view addSubview:header];
    header.titles = @[@"大奖专家组合",
                      @"开奖历史",
                      @"中奖资讯",
                      @"走势图",
                      @"购彩技巧"];
    header.titleColor = [UIColor blackColor];
    header.sliderColor = [UIColor redColor];
    header.headerBGColor = kGlobalBg;
    header.titleClickCallback = ^(NSString *title , NSInteger index){
        
        DLog(@"%@ ",title);
        DLog(@"%zd",index);
        // 不同页面有不同接口
        
        [self loadNewsWithNewsType:index];
        
    };
    // 一进来默认先点击一次第一个title（内部已经实现）
    [XYHttpTool cancelPreviousRequest];// 先关闭所有请求,继承的父类那个请求，返回较慢，就直接赋值为空了
    
    
    self.tableView.frame = CGRectMake(0, 30, ScreenW, ScreenH - 30);
    [self.tableView registerNib:[UINib nibWithNibName:@"XYNewsZuheFirstCell" bundle:nil] forCellReuseIdentifier:k_ZuheFirstCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYPreSurveyCell" bundle:nil] forCellReuseIdentifier:k_PreSurveyCelID];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYNewsHistoryCell" bundle:nil] forCellReuseIdentifier:k_newsHistoryCellID];
    
    
}

- (void)loadNewsWithNewsType:(XYNewsType)type
{
    // 保存自己的newstype
    _newsType = type;
    
    switch (type) {
        case XYNewsTypeZuhe:
        {
            NSString *base_url = @"http://115.29.175.83/cpyc/gethitzhuhe.php";
            [self loadDataWithBaseUrl:base_url lotType:[XYTools currentLotType] curIndex:type];
        }
            break;
        case XYNewsTypeHistory:
        {
            NSString *base_url = @"http://115.29.175.83/cpyc/getlothis.php";
            [self loadDataWithBaseUrl:base_url lotType:[XYTools currentLotType] curIndex:type];
        }
            break;
        case XYNewsTypeNews:
        {
            
            NSString *base_url = @"http://115.29.175.83/cpyc/zjnews.php";
            [self loadDataWithBaseUrl:base_url lotType:[XYTools currentLotType] curIndex:type];
        }
            break;
        case XYNewsTypeTrand:
        {
            
            NSString *base_url = @"http://115.29.175.83/cpyc/getlottrend.php";
            [self loadDataWithBaseUrl:base_url lotType:[XYTools currentLotType] curIndex:type];
        }
            break;
        case XYNewsTypeMethod:
        {
            
            NSString *base_url = @"http://115.29.175.83/cpyc/gcjqnews.php";
            [self loadDataWithBaseUrl:base_url lotType:[XYTools currentLotType] curIndex:type];
        }
            break;
            
        default:
            break;
    }
}

- (void)loadDataWithBaseUrl:(NSString *)url lotType:(NSString *)lottype curIndex:(NSInteger)curindex
{
    XYRequestParam *params = [XYRequestParam new];
    params.lottype = lottype;
    params.curindex = curindex;
    [XYHttpTool getWithURL:url params:params.keyValues success:^(id json) {
        
        self.model = [XYSurveyModel objectWithKeyValues:json];
        self.list = [XYSurveyListModel objectArrayWithKeyValuesArray:json[@"list"]];
        
        [self reloadPageData];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    XYNewsZuheFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:k_ZuheFirstCellID];
//    cell.model = self.model;
//    return cell;
    
    switch (self.newsType) {
        case XYNewsTypeZuhe:
        {
            if (indexPath.row == 0) {

                XYNewsZuheFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:k_ZuheFirstCellID];
                cell.model = self.model;
                return cell;

            }else
            {
                XYPreSurveyCell *cell = [tableView dequeueReusableCellWithIdentifier:k_PreSurveyCelID];
                cell.model = self.list[indexPath.row];
                cell.hidIconBtn = YES;
                return cell;
            }
        }
            break;
        case XYNewsTypeHistory:
        {
            XYNewsHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:k_newsHistoryCellID];
            cell.model = self.list[indexPath.row];
            return cell;
        }
            break;
        case XYNewsTypeTrand:
        {
            // 走势图这里可以直接就用系统cell就OK
            static NSString *cellID = @"trendCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
            
            XYSurveyListModel *model = self.list[indexPath.row];
            cell.textLabel.text = model.trendname;
            return cell;
        }
            break;
        case XYNewsTypeNews:
        {
            // 中奖资讯
            
            static NSString *cellID = @"newsCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
            
            XYSurveyListModel *model = self.list[indexPath.row];
            cell.textLabel.text = model.pubaddr;
            cell.detailTextLabel.text = model.title;
            UILabel *timeLabel = [UILabel new];
            timeLabel.text = model.pubdate;
            [timeLabel sizeToFit];
            cell.accessoryView = timeLabel;
            return cell;
            
        }
        case XYNewsTypeMethod:
        {
            // 同上一种cell
            static NSString *cellID = @"methodCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
            
            XYSurveyListModel *model = self.list[indexPath.row];
            cell.textLabel.text = model.pubaddr;
            cell.detailTextLabel.text = model.title;
            UILabel *timeLabel = [UILabel new];
            timeLabel.text = model.pubdate;
            [timeLabel sizeToFit];
            cell.accessoryView = timeLabel;
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return [UITableViewCell new];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.newsType) {
        case XYNewsTypeZuhe:
        {
            if (indexPath.row == 0) {

                return 65;
            }else
            {
                return 100;
            }
        }
            break;
        case XYNewsTypeHistory:
        {
            return 70;
        }
            break;
        case XYNewsTypeNews:
        {
            // 这和下面的一样，直接走下边
            return 45;
        }
            break;
        case XYNewsTypeTrand:
        {
            return 45;
        }
            break;
        case XYNewsTypeMethod:
        {
            // 同上一种cell
            return 45;
        }
            break;
            
        default:
            break;
    }
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    switch (self.newsType) {
//        case XYNewsTypeZuhe:
//        {
//            if (indexPath.row == 0) {
//                
//                
//                
//            }else
//            {
//                
//            }
//        }
//            break;
//        case XYNewsTypeHistory:
//        {
//            
//        }
//            break;
//        case XYNewsTypeTrand:
//        {
//            
//            
//        }
//            break;
//        case XYNewsTypeNews:
//        {
//            // 这和下面的一样，直接走下边
//        }
//        case XYNewsTypeMethod:
//        {
//            // 同上一种cell
//        }
//            break;
//            
//        default:
//            break;
//    }
//}



@end
