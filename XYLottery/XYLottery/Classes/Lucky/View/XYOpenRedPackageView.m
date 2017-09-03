//
//  XYOpenRedPackageView.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/9/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYOpenRedPackageView.h"
#import "XYRedResultView.h"

@interface XYOpenRedPackageView ()

@property (weak, nonatomic) IBOutlet UILabel *openLabel;
@property (weak, nonatomic) IBOutlet UIImageView *openBGImage;

@property(nonatomic , strong) XYRedResultView  *resultView;


@end

@implementation XYOpenRedPackageView

- (XYRedResultView *)resultView
{
    if (_resultView == nil) {
        _resultView = [[NSBundle mainBundle] loadNibNamed:@"XYRedResultView" owner:nil options:0].lastObject;
        _resultView.frame = self.bounds;
    }
    return _resultView;
}



- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTaped:)];
    self.openLabel.userInteractionEnabled = YES;
    [self.openLabel addGestureRecognizer:tap];
}


/**
    点击开红包按钮
 */
- (void)labelTaped:(UITapGestureRecognizer *)tap
{
    self.openBGImage.highlighted = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.openBGImage.highlighted = NO;
    });
    
#warning TODO 这里要加一个 HUD 提示正在抢红包，给用户一个真实的感觉，看看有没有接口之类的
    // 1.每次进来判断时间是不是上个时间，如果是上个时间的话就两次机会，第二次提示下个时间再来，
    // 2.如果是新的时间，就提示抱歉，你已经抢过了，提示下一次再来。
    
    [XYHttpTool getWithURL:@"http://115.29.175.83/cpyc/grabredpacket.php" params:nil success:^(id json) {
        [SVProgressHUD show];
        
        CGFloat timeDelay = (CGFloat)((CGFloat)arc4random_uniform(10) / 10) + 0.3;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            // 展示开红包结果图层
            __weak __typeof__(self) weakSelf = self;
            [self addSubview:self.resultView];
            // 给自己的ResultView赋值是否展示失败页面
            self.resultView.showFailPage = ![self checkIfHourChanges];
            self.resultView.closeCallBack = ^{
                // 用户点击了close
                if (weakSelf.callBack) { // 这个CallBack好像就是隐藏用的了，目前是没有其他用途了
                    weakSelf.callBack(weakSelf);
                }
                
                [weakSelf.resultView removeFromSuperview];// 这个也需要移除，否则下次进入的时候直接在上面
            };
            
        });
        
    } failure:^(NSError *error) {
        
    }];
}


/**
    判断是否为同一小时
 */
- (BOOL)checkIfHourChanges
{
    
    // 另一种思路：只有时间改了，才会出现第一次抱歉页面。其余都是第二页失败页面。
    
#define k_lastHour @"lastHour"
    // 1.获得当前时间的小时和上一次的比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour;
    NSDateComponents *cmps = [calendar components:unit fromDate:[NSDate date]];
    NSInteger lastHour = [kUserDefaults integerForKey:k_lastHour];
    
    if (cmps.hour % 24 != lastHour) { // 时间改变了：机会重置为 YES
        
        lastHour = cmps.hour % 24;
        [kUserDefaults setInteger:lastHour forKey:k_lastHour];
        return YES;
    }else
    {
        return NO;
    }
    
    return NO;
#undef k_lastHour
    
}



@end
