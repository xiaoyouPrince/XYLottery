//
//  XYKitMacro.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#ifndef XYKitMacro_h
#define XYKitMacro_h

#pragma mark --- 一些常用宏的配置

// 1.判断是否为iOS7以上
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 2.获得RGB颜色
#define XYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define XYRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha: (a)]
// 3.获得随机颜色
#define XYRandomColor XYColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 4.通知中心
#define kNotificationCenter [NSNotificationCenter defaultCenter]

// 5.userDefault
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kGlobalBg XYColor(232, 233, 232)

//** 屏幕参数 ***********************************************************************************
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

// 适配iphone6 所以用的它的分辨率 -- 因为标注都是按这个来的
// 公式：x = y * k；   ----> 坐标值 = 标尺 * 比率
#define widthRate ScreenW/750
#define heightRate ScreenH/1334


// 系统控件默认高度
#define kStatusBarHeight        (20.f)

#define kTopBarHeight           (44.f)
#define kBottomBarHeight        (49.f)
#define kNavHeight              (64.f)

#define kCellDefaultHeight      (44.f)

#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)


// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)
#define MaxYnv(nv)                 CGRectGetMaxY((nv))
#define MaxXnv(nv)                 CGRectGetMaxX((nv))


#define RECT_CHANGE_x(v,x)          CGRectMake(x, Y(v), WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_y(v,y)          CGRectMake(X(v), y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_point(v,x,y)    CGRectMake(x, y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_width(v,w)      CGRectMake(X(v), Y(v), w, HEIGHT(v))
#define RECT_CHANGE_height(v,h)     CGRectMake(X(v), Y(v), WIDTH(v), h)
#define RECT_CHANGE_size(v,w,h)     CGRectMake(X(v), Y(v), w, h)

//** 沙盒路径 ***********************************************************************************
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/* ****************************************************************************************************************** */
/** DEBUG LOG **/
#ifdef DEBUG

#define DLog(...) NSLog( @"< %s:(第%d行) > %@",__func__ , __LINE__, [NSString stringWithFormat:__VA_ARGS__] )

#else

#define DLog( s, ... )

#endif
/* ****************************************************************************************************************** */

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

/* ****************************************************************************************************************** */
#pragma mark - Constants (宏 常量)


/** 时间间隔 */
#define kHUDDuration            (1.f)

/** 一天的秒数 */
#define SecondsOfDay            (24.f * 60.f * 60.f)
/** 秒数 */
#define Seconds(Days)           (24.f * 60.f * 60.f * (Days))

/** 一天的毫秒数 */
#define MillisecondsOfDay       (24.f * 60.f * 60.f * 1000.f)
/** 毫秒数 */
#define Milliseconds(Days)      (24.f * 60.f * 60.f * 1000.f * (Days))


//** textAlignment ***********************************************************************************

//** #if defined ********* #else ******** #endif ******************************************************************

#if !defined __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0
# define LINE_BREAK_WORD_WRAP UILineBreakModeWordWrap
# define TextAlignmentLeft UITextAlignmentLeft
# define TextAlignmentCenter UITextAlignmentCenter
# define TextAlignmentRight UITextAlignmentRight

#else
# define LINE_BREAK_WORD_WRAP NSLineBreakByWordWrapping
# define TextAlignmentLeft NSTextAlignmentLeft
# define TextAlignmentCenter NSTextAlignmentCenter
# define TextAlignmentRight NSTextAlignmentRight

#endif


#endif /* XYKitMacro_h */
