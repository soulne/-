//
//  YFBTableViewController.h
//  YFB
//
//  Created by yangfubin on 2018/8/29.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBViewController.h"

@interface YFBTableViewController : YFBViewController

@property (assign, nonatomic, readonly) UIEdgeInsets contentInset;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
