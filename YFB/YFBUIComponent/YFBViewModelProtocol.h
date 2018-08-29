//
//  YFBViewModelProtocol.h
//  YFB
//
//  Created by wood on 2018/5/22.
//  Copyright © 2018年 construction. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "Constants.h"

@protocol YFBViewModelProtocol <NSObject>

@required

/**
 初始化方法

 @param params 参数
 @return 实例对象
 */
- (id <YFBViewModelProtocol>)initWithParams:(id)params;


@optional

/**
 viewModel将要不可见的信号
 */
@property (nonatomic, strong) RACSignal *viewModelWillDisappearSignal;

/**
 *  初始化数据、命令等，该方法会在`initWithParams`方法执行完之后执行，需继承自`YFBViewModel`
 */
- (void)initialize;

/**
 *  获取回调的block
 *
 *  @return 回调的block
 */
- (IDBlock_id)getCallbackBlock;

/**
 对应的 viewController 的 viewDidLoad 方法被调用后触发
 */
- (void)viewDidLoad;

/**
 *  viewModel将要不可见时触发
 *
 *  @param animated 是否使用动画
 */
- (void)viewModelWillDisappear:(BOOL)animated;

@end
