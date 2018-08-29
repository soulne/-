//
//  YFBTableViewController.m
//  YFB
//
//  Created by yangfubin on 2018/8/29.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBTableViewController.h"
#import "YFBTableViewModel.h"
#import <MJRefresh/MJRefresh.h>

@interface YFBTableViewController ()

@property (nonatomic, strong) YFBTableViewModel *viewModel;

@end

@implementation YFBTableViewController

- (void)setView:(UIView *)view {
    [super setView:view];
    if ([view isKindOfClass:[UITableView class]]) {
        self.tableView = (UITableView *)view;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    if (self.viewModel.shouldRequestRemoteDataOnViewDidLoad) {
        [self.viewModel.requestRemoteDataCommand execute:@1];
    }
}

- (void)setUpUI {
    [super setUpUI];
    
    @weakify(self)
    self.tableView.contentOffset = CGPointMake(0, -self.contentInset.top);
    self.tableView.contentInset  = self.contentInset;
    self.tableView.scrollIndicatorInsets = self.contentInset;
    
    self.tableView.sectionIndexColor = [UIColor blackColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    if (self.viewModel.addPullToRefresh) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [[[self.viewModel.requestRemoteDataCommand execute:@(1)]
              deliverOn:[RACScheduler mainThreadScheduler]]
             subscribeNext:^(id x) {
                 @strongify(self)
                 [self.tableView.mj_header endRefreshing];
             } error:^(NSError *error) {
                 @strongify(self)
                 [self.tableView.mj_header endRefreshing];
             } completed:^{
                 @strongify(self)
                 [self.tableView.mj_header endRefreshing];
             }];
        }];
        
        self.tableView.mj_header.automaticallyChangeAlpha = YES;
    }
    
    if (self.viewModel.addInfiniteScrolling) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [[[self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.currentPage + 1)]
              deliverOn:[RACScheduler mainThreadScheduler]]
             subscribeNext:^(id x) {
                 @strongify(self)
                 [self.tableView.mj_footer endRefreshing];
             } error:^(NSError *error) {
                 @strongify(self)
                 [self.tableView.mj_footer endRefreshing];
             } completed:^{
                 @strongify(self)
                 [self.tableView.mj_footer endRefreshing];
             }];
        }];
        
        // 当列表的项数大于等于pageSize的时候才显示上拉加载，否则隐藏上拉加载功能
        [RACObserve(self.viewModel, remoteData) subscribeNext:^(NSArray *remoteData) {
            @strongify(self)
            self.tableView.mj_footer.hidden = !(remoteData.count >= self.viewModel.pageSize);
        }];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    return cell;
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsZero;
}

@end
