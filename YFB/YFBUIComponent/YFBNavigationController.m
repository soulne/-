//
//  YFBNavigationController.m
//  YFB
//
//  Created by yangfubin on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBNavigationController.h"

@interface YFBNavigationController ()

@end

@implementation YFBNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone){
        
        UIView* bgView=[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 22.0f)];
        bgView.backgroundColor=[UIColor colorWithRed:70/255.0 green:135/255.0 blue:199/255.0 alpha:1];
        [self.view addSubview:bgView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate {
    return YES;
}

@end
