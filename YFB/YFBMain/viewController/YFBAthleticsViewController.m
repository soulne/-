//
//  YFBAthleticsViewController.m
//  YFB
//
//  Created by yangfubin on 2018/8/29.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBAthleticsViewController.h"
#import "YFBAthleticsViewModel.h"

@interface YFBAthleticsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *teamAinputTableView;
@property (weak, nonatomic) IBOutlet UITableView *teamBinputTableView;
@property (weak, nonatomic) IBOutlet UITableView *teamAoutPutTableView;
@property (weak, nonatomic) IBOutlet UITableView *teamBoutPutTabelView;
@property (nonatomic, strong) YFBAthleticsViewModel *viewModel;

@end

@implementation YFBAthleticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSString *identifier in self.viewModel.viewModelViewMappings.allValues) {
        if ([[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"]) {
            [self.teamAinputTableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
        } else {
            [self.teamAinputTableView registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.teamAinputTableView) {
        return self.viewModel.teamAinputDataSource.count;
    } else if (tableView == self.teamBinputTableView) {
        return self.viewModel.teamBinputDataSource.count;
    } else if (tableView == self.teamAoutPutTableView) {
        return self.viewModel.teamAoutputDataSource.count;
    } else if (tableView == self.teamBoutPutTabelView) {
        return self.viewModel.teamBinputDataSource.count;
    }
    return 0;
}


@end
