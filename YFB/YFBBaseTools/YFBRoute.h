//
//  YFBRoute.h
//  YFB
//
//  Created by yangfubin on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const void *YFBRouteCallbackBlockKey;


@interface YFBRoute : NSObject

@property (strong, nonatomic) NSString *route;

+ (instancetype)routeFromString:(NSString *)string;

@end
