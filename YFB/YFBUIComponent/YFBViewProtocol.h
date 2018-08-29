//
//  YFBViewProtocol.h
//  YFB
//
//  Created by wood on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YFBViewProtocol <NSObject>

@required

/**
 *  初始化方法
 *
 *  @param viewModel 对应的viewModel
 *
 *  @return 实例对象
 */
- (id <YFBViewProtocol>)initWithViewModel:(id)viewModel;

@optional

/**
 *  设置UI，该方法在`viewDidLoad`方法执行完之后执行，需继承自`YFBViewController`
 */
- (void)setUpUI;

/**
 *  绑定对应的viewModel，该方法在`viewDidLoad`方法执行完之后执行，需继承自`YFBViewController`
 */
- (void)bindViewModel;

@end
