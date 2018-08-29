//
//  YFBViewController.m
//  YFB
//
//  Created by wood on 2018/5/22.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBViewController.h"
#import "YFBViewModel.h"

@interface YFBViewController ()

@end

@implementation YFBViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
	YFBViewController *viewController = [super allocWithZone:zone];
	
	@weakify(viewController)
	[[viewController
	  	rac_signalForSelector:@selector(viewDidLoad)]
	 	subscribeNext:^(id x) {
			@strongify(viewController)
		 
			id<YFBViewModelProtocol> viewModel = viewController.viewModel;
			if ([viewModel respondsToSelector:@selector(viewDidLoad)]) {
				[viewModel viewDidLoad];
			}
		 
			[viewController setUpUI];
			[viewController bindViewModel];
		}];
	
	[[viewController
	  	rac_signalForSelector:@selector(viewWillDisappear:)]
	 	subscribeNext:^(RACTuple *tuple) {
			@strongify(viewController)
			if ([viewController.viewModel respondsToSelector:@selector(viewModelWillDisappear:)]) {
				[viewController.viewModel viewModelWillDisappear:[tuple.first boolValue]];
			}
		}];
	
	return viewController;
}

- (id<YFBViewProtocol>)initWithViewModel:(id)viewModel {
	self = [super init];
	if (self) {
		self.viewModel = viewModel;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.edgesForExtendedLayout = UIRectEdgeAll;
	self.extendedLayoutIncludesOpaqueBars = YES;
	self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)setUpUI {
}

- (void)bindViewModel {
}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
	return [self.viewModel statusBarHidden];
}

@end
