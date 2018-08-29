//
//  YFBMainViewController.m
//  YFB
//
//  Created by yangfubin on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBMainViewController.h"
#import "YFBMainViewModel.h"
#import "Constants.h"
#import "YFBRouter.h"
#import "YFBApplication.h"
#import "VTMagic.h"

@interface YFBMainViewController ()<VTMagicViewDataSource, VTMagicViewDelegate>

@property (nonatomic, strong) YFBMainViewModel *viewModel;
@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) NSArray *menuList;
@property (nonatomic, strong) NSArray *childViewControllersArray;

@end

@implementation YFBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.view setNeedsUpdateConstraints];
    [self integrateComponents];
    [self.magicController.magicView reloadData];
    
    self.yfb_prefersNavigationBarHidden = YES;
}

- (void)updateViewConstraints {
    UIView *magicView = _magicController.view;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[magicView]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(magicView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[magicView]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(magicView)]];
    
    [super updateViewConstraints];
}

#pragma mark - functional methods
- (void)integrateComponents {
    UIButton *myPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myPageButton setImage:[UIImage imageNamed:@"magic_search"] forState:UIControlStateNormal];
    [myPageButton addTarget:self action:@selector(myPageAction:) forControlEvents:UIControlEventTouchUpInside];
    myPageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [myPageButton setTitle:@"我的" forState:UIControlStateNormal];
    myPageButton.frame = CGRectMake(0, 0, 36, 36);
    [self.magicController.magicView setLeftNavigatoinItem:myPageButton];
}

#pragma mark - actions
- (void)myPageAction:(UIButton *)sender {
    NSLog(@"myPageAction");
}


#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    return self.menuList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
        [menuItem setTitleColor:HexRGB(0x84BD00) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    
    return self.childViewControllersArray[pageIndex];
}

#pragma mark - accessor methods
- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.view.translatesAutoresizingMaskIntoConstraints = NO;
        _magicController.magicView.navigationInset = UIEdgeInsetsMake(0, 0, 0, 36);
        _magicController.magicView.navigationColor = HexRGB(0x00454E);
        _magicController.magicView.sliderColor = HexRGB(0x84BD00);
        _magicController.magicView.layoutStyle = VTLayoutStyleCenter;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.navigationHeight = 44.f;
        _magicController.magicView.againstStatusBar = YES;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}

- (NSArray *)menuList {
    if (!_menuList) {
        _menuList = @[ @"游戏竞技", @"足球" ];
    }
    return _menuList;
}


- (NSArray<UIViewController *> *)childViewControllersArray {
    
    if (!_childViewControllersArray) {
        NSArray *viewModelNames = @[];
        NSArray *params = @[];
        
        NSMutableArray *childViewControllers = [NSMutableArray array];
        for (NSInteger i = 0; i < viewModelNames.count; i++) {
            YFBRoute *route = [YFBRoute routeFromString:viewModelNames[i]];
            id viewController = [[YFBRouter sharedRouter] viewControllerWithRoute:route params:params[i] callback:nil];
            [childViewControllers addObject:viewController];
        }
        
        _childViewControllersArray = childViewControllers.copy;
    }
    return _childViewControllersArray;
}



@end
