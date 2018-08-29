//
//  YFBNetworkManager.h
//  YFB
//
//  Created by wood on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "YFBNetworkManagerProtocol.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface YFBNetworkManager : NSObject <YFBNetworkManagerProtocol>

@property (nonatomic, strong, readonly) NSURL *baseURL;
@property (nonatomic, strong, readonly) NSURLSessionDataTask *sessionDataTask;
@property (nonatomic, copy, readonly) NSDictionary *allHeader;

- (instancetype)init __attribute__((unavailable("Use -initWithBaseURL: instead")));

/**
 初始化
 
 @param url 服务器地址
 @return 实例对象
 */
- (instancetype)initWithBaseURL:(NSURL *)url;


/**
 网络请求

 @param method GET、POST
 @param URLString 接口地址
 @param parameters 请求参数
 @return signal
 */
+ (RACSignal *)requestWithMethod:(NSString *)method
					   URLString:(NSString *)URLString
					  parameters:(id)parameters;


/**
 表单请求-POST

 @param URLString 接口地址
 @param parameters post数据
 @param fileDatas 文件数据
 @param fileInfoData 文件信息（name、fileName、mimeType）
 @return signal
 */
+ (RACSignal *)postMultipartFormDataWithURLString:(NSString *)URLString
									   parameters:(NSDictionary *)parameters
										fileDatas:(NSArray *)fileDatas
									 fileInfoData:(NSArray *)fileInfoData;

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
 表单请求（POST）

 @param URLString 接口路径
 @param parameters 表单数据 key/value 参数字典
 @param block 返回表单体，可在 block 里进行添加不同类型格式的表单
 @param progress 提交时进度
 @param successBlock 成功block
 @param failureBlock 失败block
 @return 请求实例
 */
- (instancetype)postMultipartFormDataWithURLString:(NSString *) URLString
										parameters:(NSDictionary *) parameters
						 constructingBodyWithBlock: (void (^)(id <AFMultipartFormData> formData))block
										  progress:(NSProgress * __autoreleasing *)progress
										   success:(YFBSuccessBlock)successBlock
										   failure:(YFBFailureBlock)failureBlock;

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters;

/**
 取消网络请求
 */
- (void)cancelRequestOperation;

@end
