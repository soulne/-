//
//  YFBTableViewModel.h
//  YFB
//
//  Created by yangfubin on 2018/8/29.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBViewModel.h"

@interface YFBTableViewModel : YFBViewModel {

RACCommand *_selectCommand;
}

///  请求远程数据的命令
@property (strong, nonatomic) RACCommand *requestRemoteDataCommand;

@property (nonatomic, strong) NSArray *remoteData;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger pageTotal;
@property (nonatomic, assign) BOOL shouldRequestRemoteDataOnViewDidLoad;

///  是否添加下拉刷新功能，默认为NO
@property (nonatomic) BOOL addPullToRefresh;

///  是否添加上拉加载功能，默认为NO
@property (nonatomic) BOOL addInfiniteScrolling;

@property (nonatomic, strong) RACCommand *selectCommand;

//子类必须实现
- (NSArray *)dataArrayFromResponseObject:(NSDictionary *)responseObject;

- (RACSignal *)requestRemoteDataSignalWithCurrentPage:(NSUInteger)currentPage;

@end
