//
//  XYNewsDetailViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/20.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYNewsDetailViewController.h"

@interface XYNewsDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *web;

@end

@implementation XYNewsDetailViewController



//- (NSDictionary *)titleDict
//{
//    if (_titleDict == nil) {
//        _titleDict = @{@"ssq" : @"双色球",
//                       @"dlt" : @"超级大乐透",
//                       @"jczq" : @"竞彩足球",
//                       @"jclq" : @"竞彩篮球",
//                       @"zc" : @"足彩",
//                       @"bjdc" : @"北京单场",
//                       @"3d" : @"福彩3D",
//                       @"pl3" : @"排列三",
//                       };
//        
//    }
//    return _titleDict;
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIWebView *web = [UIWebView new];
    web.delegate = self;
    web.frame = self.view.bounds;
    //    web.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 65, 0);
    [self.view addSubview:web];
    self.web = web;
    [web loadRequest:self.request];
    
//    self.title = self.titleDict[[self.request.URL lastPathComponent]];
}


//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    //    webView
//    // 执行JS代码实现--这里移除头部，只是进来的时候移除一次，
//    
//    NSString *jsCode = @"var headerElement = document.getElementsByTagName('header')[0];"
//    "headerElement.parentNode.removeChild(headerElement);";
//    [webView stringByEvaluatingJavaScriptFromString:jsCode];
//    
//}
//
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    
//    if ([request.URL.absoluteString containsString:@"html"]) {
//        // 进入子页面
//        // 即热点资讯页面
////        HotInfoViewController *hot = [HotInfoViewController new];
////        hot.request = request;
////        [self.navigationController pushViewController:hot animated:YES];
//        
//        return NO;
//    }
//    
//    return YES;
//    
//}



@end
