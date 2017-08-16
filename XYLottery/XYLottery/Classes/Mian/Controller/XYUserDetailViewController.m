//
//  XYUserDetailViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/14.
//  Copyright © 2017年 渠晓友. All rights reserved.
//


#import "XYUserDetailViewController.h"


@interface XYUserDetail : NSObject

@property(nonatomic , copy) NSString *breif;
@property(nonatomic , strong) NSNumber  *fans;
@property(nonatomic , strong) NSNumber  *follows;
@property(nonatomic , strong) NSNumber  *score;
@property(nonatomic , strong) NSNumber  *sumscore;
@property(nonatomic,assign) BOOL isexpert;
@property(nonatomic,assign) BOOL isfollow;
@property(nonatomic , copy) NSString *lottype;
@property(nonatomic , copy) NSString *medalindex;
@property(nonatomic , copy) NSString *userid;
@property(nonatomic , copy) NSString *username;

@end

@implementation XYUserDetail

@end

@interface XYUserDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *isExpertLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet UILabel *fellowLabel;
@property (weak, nonatomic) IBOutlet UIButton *fellowBtn;
@property (weak, nonatomic) IBOutlet UILabel *breifLabel;
@property (weak, nonatomic) IBOutlet UIButton *lottypeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *inderImage;
@property (weak, nonatomic) IBOutlet UIScrollView *sortScrollView;




@end

@implementation XYUserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 一次性设置
    ViewBorderRadius(self.isExpertLabel, 3, 0.5, [UIColor clearColor]);
    ViewBorderRadius(self.fellowBtn, 3, 0.5, [UIColor clearColor]);
    
    [self loadData];
}

- (void)loadData
{
    [self loadUserData];
}


// 请求用户数据
- (void)loadUserData
{
    
    [SVProgressHUD show];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:@"0" forKey:@"userid"];
    [params setValue:_desid forKey:@"desid"];
    [params setValue:[XYTools currentLottery] forKey:@"lottype"];
    [params setValue:@"1.4.5" forKey:@"iosversion"];
    
#define k_getUserDetailUrl @"http://115.29.175.83/cpyc/getpersonal.php"
    
    [XYHttpTool getWithURL:k_getUserDetailUrl params:params success:^(NSDictionary * json) {
        
        XYUserDetail *user = [XYUserDetail objectWithKeyValues:json];
        
        if ([json[@"errorcode"] integerValue] == 0) {
            
            // 给各个组件赋值
            self.userNameLabel.text = user.username;
            self.isExpertLabel.hidden = !user.isexpert;
            self.fansLabel.text = [NSString stringWithFormat:@"粉丝:%@人",user.fans];
            self.fellowLabel.text = [NSString stringWithFormat:@"关注:%@人",user.follows];
            if (user.breif.length) {
                self.breifLabel.text = user.breif;
            }else
            {
                self.breifLabel.text = @"这个家伙很懒，居然没有写简介";
            }
            
            [self.lottypeBtn setTitle:[XYTools currentLotName] forState:0];
            // 同样加载一下对应的playtype们

        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        
    }];
    
#undef k_getUserDetailUrl
    
    
    
    
}



- (IBAction)followBtnClick:(UIButton *)sender {
    
    // 请求关注按钮
    
    
    
}

- (IBAction)lottypeBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    // 出现蒙版
    [self showLottypeCover:sender];
    
    [self checkLottypeBtnisSelected];
}

- (void)checkLottypeBtnisSelected
{
    // 切换彩票玩法类型
    if (self.lottypeBtn.selected) {
        
        self.inderImage.image = [UIImage imageNamed:@"expand_down"];
        
    }else
    {
        self.inderImage.image = [UIImage imageNamed:@"expand_up"];
    }
}

- (void)showLottypeCover:(UIButton *)sender
{
    UIView *coverView = [UIView new];
    coverView.frame = [UIScreen mainScreen].bounds;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick:)];
    [coverView addGestureRecognizer:tap];
    [self.view addSubview:coverView];
    
    // 选择类型背景板 h = 210
    UIView *typeView = [UIView new];
    typeView.backgroundColor = [UIColor greenColor];
    [coverView addSubview:typeView];
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sender.mas_left).offset(5);
        make.top.mas_equalTo(sender.mas_bottom).offset(5);
        make.width.mas_equalTo(100);
        make.height.equalTo(@210);
    }];
    
    // 添加按钮
    NSArray<XYLottery*> *lotterys = [XYTools lotteryData].list;
    for (int i = 0; i < lotterys.count; i++) {
        
        UIButton *btn = [UIButton new];
        [typeView addSubview:btn];
        btn.tag = lotterys[i].lottype.integerValue; // 这是根据类型类决定的
        btn.backgroundColor = [UIColor blackColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitle:lotterys[i].lotname forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(typeView.mas_left);
            make.right.mas_equalTo(typeView.mas_right);
            make.top.mas_equalTo(typeView.mas_top).offset(i * 30);
            make.height.mas_equalTo(30);
        }];
        
    }

}


- (void)coverClick:(UITapGestureRecognizer *)tap
{
    [tap.view removeFromSuperview];
    [self.lottypeBtn setSelected:NO];
    [self checkLottypeBtnisSelected];
}

/**
 lottype的按钮点击
 */
- (void)btnClick:(UIButton *)btn
{
    // 修改原Btn的默认值
    [self.lottypeBtn setTitle:btn.currentTitle forState:UIControlStateNormal];
    [self.lottypeBtn setSelected:NO];
    [self checkLottypeBtnisSelected];
    [btn.superview.superview removeFromSuperview]; // 蒙版移除
    
//#warning 处理对应的几期，都是展示同样的内容吧。。
    
    
    
}





@end
