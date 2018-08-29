//
//  YFBViewModel.m
//  YFB
//
//  Created by wood on 2018/5/22.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBViewModel.h"
#import <objc/runtime.h>

const void *YFBCallbackBlockKey = &YFBCallbackBlockKey;

@implementation YFBViewModel

@synthesize viewModelWillDisappearSignal = _viewModelWillDisappearSignal;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
	YFBViewModel *viewModel = [super allocWithZone:zone];
	@weakify(viewModel)
	[[viewModel
	  rac_signalForSelector:@selector(initWithParams:)]
	 subscribeNext:^(id x) {
		 @strongify(viewModel)
		 [viewModel initialize];
	 }];
	return viewModel;
}

- (id <YFBViewModelProtocol>)initWithParams:(id)params {
	self = [super init];
	if (self) {
		self.params = params;
	}
	return self;
}

- (RACSignal *)viewModelWillDisappearSignal {
	if (!_viewModelWillDisappearSignal) {
		_viewModelWillDisappearSignal = [self rac_signalForSelector:@selector(viewModelWillDisappear:)];
	}
	return _viewModelWillDisappearSignal;
}

- (void)initialize {
}

- (IDBlock_id)getCallbackBlock {
	return objc_getAssociatedObject(self, YFBCallbackBlockKey);
}

- (void)viewModelWillDisappear:(BOOL)animated {
}

@end
