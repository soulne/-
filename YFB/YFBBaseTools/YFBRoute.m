//
//  YFBRoute.m
//  YFB
//
//  Created by yangfubin on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBRoute.h"

const void *YFBRouteCallbackBlockKey = &YFBRouteCallbackBlockKey;

@implementation YFBRoute

+ (instancetype)routeFromString:(NSString *)string {
    YFBRoute *route = [YFBRoute new];
    route.route      = string;
    return route;
}


@end
