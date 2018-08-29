//
//  YFBRouter.m
//  YFB
//
//  Created by yangfubin on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBRouter.h"
#import "YFBViewModelProtocol.h"
#import "YFBViewProtocol.h"
#import <objc/runtime.h>


@interface YFBRouter()

@property (strong, nonatomic) NSDictionary *viewModelRoutes;
@property (strong, nonatomic) NSDictionary *viewModelViewMappings;

@end

@implementation YFBRouter

static YFBRouter *sharedRouter;
+ (instancetype)sharedRouter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRouter = [YFBRouter new];
        [sharedRouter initialize];
    });
    return sharedRouter;
}

- (id)viewControllerWithRoute:(YFBRoute *)route params:(id)params callback:(IDBlock_id)callback {
    NSString *viewModelName = route.route;
    
    NSParameterAssert([NSClassFromString(viewModelName) conformsToProtocol:@protocol(YFBViewModelProtocol)]);
    NSParameterAssert([NSClassFromString(viewModelName) instancesRespondToSelector:@selector(initWithParams:)]);
    
    id <YFBViewModelProtocol> viewModel = [[NSClassFromString(viewModelName) alloc] initWithParams:params];
    
    if (callback != nil) {
        objc_setAssociatedObject(viewModel, YFBRouteCallbackBlockKey, callback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSString *viewControllerName = [self.viewModelViewMappings valueForKey:viewModelName];
    
    NSParameterAssert([NSClassFromString(viewControllerName) conformsToProtocol:@protocol(YFBViewProtocol)]);
    NSParameterAssert([NSClassFromString(viewControllerName) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    id <YFBViewProtocol> viewController = [[NSClassFromString(viewControllerName) alloc] initWithViewModel:viewModel];
    
    return viewController;
}


- (void)initialize {
    _viewModelViewMappings = @{ @"YFBMainViewModel": @"YFBMainViewController",
                                @"YFBAthleticsViewModel": @"YFBAthleticsViewController"
                                };
}


@end
