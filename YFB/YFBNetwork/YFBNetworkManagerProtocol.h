//
//  YFBNetworkManagerProtocol.h
//  YFB
//
//  Created by wood on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol YFBNetworkManagerProtocol <NSObject>

@property (nonatomic, strong, readonly) NSURLSessionDataTask *sessionDataTask;

@property (nonatomic, copy, readonly) NSDictionary *allHeader;

@property (nonatomic, strong, readonly) NSURL *baseURL;

/**
 自定义成功block

 @param manager 请求对象
 @param responseObject 成功响应数据
 */
typedef void (^YFBSuccessBlock)(id<YFBNetworkManagerProtocol> manager, id responseObject);

/**
 自定义失败block

 @param manager 请求对象
 @param error 错误信息
 */
typedef void (^YFBFailureBlock)(id<YFBNetworkManagerProtocol> manager, NSError *error);


/**
 初始化

 @param url 服务器地址
 @return 实例对象
 */
- (instancetype)initWithBaseURL:(NSURL *)url;


/**
 网络请求

 @param method GET、POST
 @param URLString 接口路径
 @param parameters 请求参数
 @param successBlock 成功block
 @param failureBlock 失败block
 @return 请求实例
 */
- (instancetype)requestWithMethod:(NSString*)method
						URLString:(NSString *)URLString
					   parameters:(id)parameters
						  success:(YFBSuccessBlock)successBlock
						  failure:(YFBFailureBlock)failureBlock;


/**
 取消网络请求
 */
- (void)cancelRequestOperation;

@end
