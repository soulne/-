//
//  YFBNetworkManager.m
//  YFB
//
//  Created by wood on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBNetworkManager.h"
#import "AFNetworking.h"
#import "YFBConfig.h"

NSString * const YFBErrorDomain = @"com.construction.ErrorDomain";

@interface YFBNetworkManager () {
	id<YFBNetworkManagerProtocol> _currentManager;
}

@property (nonatomic, strong, readwrite) NSURL *baseURL;
@property (nonatomic, strong, readwrite) NSURLSessionDataTask *sessionDataTask;
@property (nonatomic, copy, readwrite) NSDictionary *allHeader;

@property (nonatomic ,strong) AFHTTPSessionManager *sessionManager;

@end

@implementation YFBNetworkManager

@synthesize sessionDataTask = _sessionDataTask;

- (NSURL*)baseURL {
	return self.sessionManager.baseURL;
}

- (NSDictionary*)allHeader {
	return self.sessionManager.requestSerializer.HTTPRequestHeaders;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
	self = [super init];
	if (self) {
		_sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:nil];
		// 请求头
		[_sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
		[_sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
		[_sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
	}
	return self;
}

+ (instancetype)manager {
	NSParameterAssert(YFB_BASE_URL);
	return [self managerWithBaseURL:[NSURL URLWithString:YFB_BASE_URL]];
}

+ (instancetype)managerWithBaseURL:(NSURL *)url {
	YFBNetworkManager *mamager = [[self alloc] initWithBaseURL:url];
	return mamager;
}

#pragma mark - RACSignal

+ (RACSignal *)requestWithMethod:(NSString *)method
					   URLString:(NSString *)URLString
					  parameters:(id)parameters {
	return [[RACSignal
			 createSignal:^(id<RACSubscriber> subscriber) {
				 id<YFBNetworkManagerProtocol> manager = ({
					 YFBNetworkManager *manager = [YFBNetworkManager manager];
					 [manager requestWithMethod:method
									  URLString:URLString
									 parameters:parameters
										success:^(id<YFBNetworkManagerProtocol> networkManager, id responseObject) {
											[subscriber sendNext:responseObject];
											[subscriber sendCompleted];
										}
										failure:^(id<YFBNetworkManagerProtocol> networkManager, NSError *error) {
											[subscriber sendError:error];
										}];
				 });
				 return [RACDisposable disposableWithBlock:^{
					 return [manager cancelRequestOperation];
				 }];
			 }]
			replayLazily];
}

+ (RACSignal *)postMultipartFormDataWithURLString:(NSString *)URLString
									   parameters:(NSDictionary *)parameters
										fileDatas:(NSArray *)fileDatas
									 fileInfoData:(NSArray *)fileInfoData {
	return [[RACSignal
				createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
					id<YFBNetworkManagerProtocol> manager = ({
						YFBNetworkManager *manager = [YFBNetworkManager manager];
						[manager postMultipartFormDataWithURLString:URLString
														 parameters:parameters
										  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
											  // 追加文件数据
											  for (int i = 0; i < fileDatas.count ; i++) {
												  if (i < fileInfoData.count) {
													  [formData appendPartWithFileData:fileDatas[i] name:fileInfoData[i][@"name"] fileName:fileInfoData[i][@"fileName"] mimeType:fileInfoData[i][@"mimeType"]];
												  }
											  }
										  }
														   progress:nil
															success:^(id<YFBNetworkManagerProtocol> manager, id responseObject) {
																[subscriber sendNext:responseObject];
																[subscriber sendCompleted];}
															failure:^(id<YFBNetworkManagerProtocol> manager, NSError *error) {
																[subscriber sendError:error];
															}];
					});
					return [RACDisposable disposableWithBlock:^{
						return [manager cancelRequestOperation];
					}];
				}]
				replayLazily];
}


#pragma mark -

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
	return [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:path parameters:parameters error:nil];
}

- (instancetype)requestWithMethod:(NSString*)method
						URLString:(NSString *)URLString
					   parameters:(id)parameters
						  success:(YFBSuccessBlock)successBlock
						  failure:(YFBFailureBlock)failureBlock {
	
	if (self.sessionDataTask.state == NSURLSessionTaskStateRunning || self.sessionDataTask.state == NSURLSessionTaskStateSuspended) {
		[self.sessionDataTask cancel];
	}
	
	__weak __typeof__(self) weakSelf = self;
		
	if ([method isEqualToString:@"GET"]) {
		self.sessionDataTask = [self.sessionManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
			
									} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
										if ([responseObject[@"code"] isEqualToString:@"1"]) {
											if (successBlock) {
												successBlock(weakSelf, responseObject);
											}
										}else{
											NSError *error = [NSError errorWithDomain:YFBErrorDomain code:[responseObject[@"code"] integerValue] userInfo:responseObject];
											if (failureBlock) {
												failureBlock(weakSelf, error);
											}
										}
									} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
										if (failureBlock) {
											failureBlock(weakSelf, error);
										}
									}];
	} else if ([method isEqualToString:@"POST"]) {
		self.sessionDataTask = [self.sessionManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
			
									} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
										if ([responseObject[@"code"] isEqualToString:@"1"]) {
											if (successBlock) {
												successBlock(weakSelf, responseObject);
											}
										}else{
											NSError *error = [NSError errorWithDomain:YFBErrorDomain code:[responseObject[@"code"] integerValue] userInfo:responseObject];
											if (failureBlock) {
												failureBlock(weakSelf, error);
											}
										}
									} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
										if (failureBlock) {
											failureBlock(weakSelf, error);
										}
									}];
	}
	
	return self;
}

// POST多表单
- (instancetype)postMultipartFormDataWithURLString:(NSString *) URLString
										parameters:(NSDictionary *) parameters
						 constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block
										  progress:(NSProgress * __autoreleasing *)progress
										   success:(YFBSuccessBlock)successBlock
										   failure:(YFBFailureBlock)failureBlock {
	__weak __typeof__(self) weakSelf = self;
	self.sessionDataTask = [self.sessionManager POST:URLString parameters:parameters constructingBodyWithBlock:block
								progress:^(NSProgress * _Nonnull uploadProgress) {
		
								} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
									if ([responseObject[@"code"] isEqualToString:@"1"]) {
										if (successBlock) {
											successBlock(weakSelf, responseObject);
										}
									}else{
										NSError *error = [NSError errorWithDomain:YFBErrorDomain code:[responseObject[@"code"] integerValue] userInfo:responseObject];
										if (failureBlock) {
											failureBlock(weakSelf, error);
										}
									}
								} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
									if (failureBlock) {
										failureBlock(weakSelf, error);
									}
								}];
	
	return self;
}

- (void)cancelRequestOperation {
	[self.sessionDataTask cancel];
	_sessionDataTask = nil;
}

@end
