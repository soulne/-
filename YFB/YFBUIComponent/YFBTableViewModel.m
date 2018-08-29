//
//  YFBTableViewModel.m
//  YFB
//
//  Created by yangfubin on 2018/8/29.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBTableViewModel.h"

@implementation YFBTableViewModel


- (id<YFBViewModelProtocol>)initWithParams:(id)params {
    self = [super initWithParams:params];
    if (self) {
        self.currentPage = 1;
        self.pageSize    = 20;
        self.shouldRequestRemoteDataOnViewDidLoad = YES;
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    @weakify(self)
    [self.requestRemoteDataCommand.executionSignals.switchToLatest
     subscribeNext:^(NSDictionary *responseObject) {
         @strongify(self)
         if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
             self.pageTotal = [responseObject[@"data"][@"pageTotal"] integerValue];
         }
         NSArray *dataArray = [self dataArrayFromResponseObject:responseObject];
         if ([dataArray isKindOfClass:[NSArray class]]) {
             if (self.currentPage <= 1) {
                 self.remoteData = dataArray;
             } else if (self.currentPage > 1) {
                 self.remoteData = [self.remoteData arrayByAddingObjectsFromArray:dataArray];
             }
         } else {
             self.remoteData = @[];
         }
     }];
}

- (RACCommand *)requestRemoteDataCommand {
    // 请求远程数据的命令
    // 根据传入的 currentPage 请求远程数据
    // 请求成功时将 self.currentPage 置为 currentPage ，即表示翻页成功
    if (_requestRemoteDataCommand == nil) {
        @weakify(self)
        _requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^(NSNumber *currentPage) {
            @strongify(self)
            return [[[self requestRemoteDataSignalWithCurrentPage:currentPage.unsignedIntegerValue]
                     doNext:^(id x) {
                         @strongify(self)
                         self.currentPage = currentPage.unsignedIntegerValue;
                     }]
                    takeUntil:self.viewModelWillDisappearSignal];
        }];
    }
    return _requestRemoteDataCommand;
}

- (RACSignal *)requestRemoteDataSignalWithCurrentPage:(NSUInteger)currentPage {
    return [self requestRemoteDataSignal];
}

- (RACSignal *)requestRemoteDataSignal {
    return [RACSignal empty];
}

- (NSArray *)dataArrayFromResponseObject:(NSDictionary *)responseObject {
    return @[];
}


@end
