//
//  YFBRouter.h
//  YFB
//
//  Created by yangfubin on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFBRoute.h"
#import "Constants.h"

@interface YFBRouter : NSObject  {
@protected
    NSDictionary *_viewModelViewMappings; // viewModel到view的映射
}

+ (instancetype)sharedRouter;

/**
 *  获取viewController
 *
 *  @param route    路由对象
 *  @param params   需要传递给viewModel的参数
 *  @param callback 回调的block
 *
 *  @return viewController
 */
- (id)viewControllerWithRoute:(YFBRoute *)route params:(id)params callback:(IDBlock_id)callback;

@end
