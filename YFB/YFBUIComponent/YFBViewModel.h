//
//  YFBViewModel.h
//  YFB
//
//  Created by wood on 2018/5/22.
//  Copyright © 2018年 construction. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFBViewModelProtocol.h"

@interface YFBViewModel : NSObject <YFBViewModelProtocol>

/**
 *  初始化参数
 */
@property (strong, nonatomic) id params;

/**
 *  状态栏是否隐藏，默认为NO
 */
@property (assign, nonatomic) BOOL statusBarHidden;

@end
