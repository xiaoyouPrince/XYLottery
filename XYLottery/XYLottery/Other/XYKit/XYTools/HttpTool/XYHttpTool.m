//
//  XYHttpTool.m
//  iTravel
//
//  Created by XiaoYou on 16/4/15.
//  Copyright © 2016年 XY. All rights reserved.
//

#define delayTime 5.0f // 设置超时时间 5s

#import "XYHttpTool.h"
#import "AFNetworking.h"

@implementation XYHttpTool

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success failure:(void(^)(NSError *error))failure
{
    // 1.创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = delayTime;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 2.发送请求
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 成功调用成功block
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        

        // 失败调用失败block
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formData:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = delayTime * 3;//这是上传照片，延时时间长一点
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    // 2.发送请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
        
        for (XYFormData* formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            // 成功去掉hud
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            // 失败去掉hud
            failure(error);
        }
    }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    // 1.创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        

        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       

        if (failure) {
            failure(error);
        }
    }];
    
}



@end


/**
 *  用来封装文件数据的模型
 */
@implementation XYFormData

@end
