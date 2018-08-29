//
//  YFBApplication.h
//  YFB
//
//  Created by yangfubin on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

#define SharedApplication [YFBApplication sharedApplication]

@protocol YFBApplicationDelegate <NSObject>

- (UIWindow *)window;

@end


@interface YFBApplication : NSObject<UIApplicationDelegate> {
    id uiApplication;
}

+(YFBApplication *)sharedApplication;



///--------------------------------------
/// UINavigationController的入栈和出栈等操作
///--------------------------------------

/**
 *  入栈
 *
 *  @param navigationController navigationController
 */
- (void)pushNavigationController:(UINavigationController *)navigationController;

/**
 *  出栈
 *
 *  @return navigationController
 */
- (UINavigationController *)popNavigationController;

/// 栈顶的 navigationController
///
/// @return 栈顶的 navigationController
- (UINavigationController *)topNavigationController;

/// 栈底的 navigationController
///
/// @return 栈底的 navigationController
- (UINavigationController *)bottomNavigationController;

/**
 *  移除所有的NavigationController
 */
- (void)removeAllNavigationControllers;

///------------------
/// 使用push水平滑动过渡
///------------------

/**
 *  参见pushViewModelWithRoute:params:animated:callback:
 *
 *  @param route 路由
 */
- (void)pushViewModelWithRoute:(NSString *)route;

/**
 *  参见pushViewModelWithRoute:params:animated:callback:
 *
 *  @param route 路由
 *  @param params 参数
 */
- (void)pushViewModelWithRoute:(NSString *)route params:(id)params;

/**
 *  参见pushViewModelWithRoute:params:animated:callback:
 *
 *  @param route 路由
 *  @param params 参数
 *  @param animated 动画
 */
- (void)pushViewModelWithRoute:(NSString *)route params:(id)params animated:(BOOL)animated;

/**
 *  使用push过渡，如果viewModel已经在堆栈中则不产生影响
 *
 *  @param route    viewModel的route
 *  @param params   需要传递给viewModel的参数
 *  @param animated 是否使用动画，默认为YES
 *  @param callback 回调的block
 */
- (void)pushViewModelWithRoute:(NSString *)route params:(id)params animated:(BOOL)animated callback:(IDBlock_id)callback;

///-----------------
/// 使用pop水平滑动过渡
///-----------------

/**
 *  参见popViewModelAnimated:step:
 */
- (void)popViewModel;

/**
 *  参见popViewModelAnimated:step:
 *
 *  @param animated 动画
 */
- (void)popViewModelAnimated:(BOOL)animated;

/**
 *  使用pop过渡
 *
 *  @param animated 是否使用动画，默认为YES
 *  @param step     步数，例如：步数为1则与直接用方法popViewModelAnimated:效果相同
 */
- (void)popViewModelAnimated:(BOOL)animated step:(NSUInteger)step;

/**
 *  参见popToRootViewModelAnimated:
 */
- (void)popToRootViewModel;

/**
 *  使用pop过渡
 *
 *  @param animated 是否使用动画，默认为YES
 */
- (void)popToRootViewModelAnimated:(BOOL)animated;

///--------------------
/// 使用present弹出和隐藏
///--------------------

/**
 *  参见presentViewModelWithRoute:params:animated:completion:callback:
 *
 *  @param route 路由
 */
- (void)presentViewModelWithRoute:(NSString *)route;

/**
 *  参见presentViewModelWithRoute:params:animated:completion:callback:
 *
 *  @param route 路由
 *  @param params 参数
 */
- (void)presentViewModelWithRoute:(NSString *)route params:(id)params;

/**
 *  参见presentViewModelWithRoute:params:animated:completion:callback:
 *
 *  @param route 路由
 *  @param params 参数
 *  @param animated 动画
 */
- (void)presentViewModelWithRoute:(NSString *)route params:(id)params animated:(BOOL)animated;

/**
 *  参见presentViewModelWithRoute:params:animated:completion:callback:
 *
 *  @param route 路由
 *  @param params 参数
 *  @param animated 是否动画
 *  @param completion 完成回调
 */
- (void)presentViewModelWithRoute:(NSString *)route params:(id)params animated:(BOOL)animated completion:(VoidBlock)completion;

/**
 *  使用present弹出viewModel
 *
 *  @param route      viewModel的route
 *  @param params     需要传递给viewModel的参数
 *  @param animated   是否使用动画，默认为YES
 *  @param completion present完成时执行的block
 *  @param callback   回调的block
 */
- (void)presentViewModelWithRoute:(NSString *)route params:(id)params animated:(BOOL)animated completion:(VoidBlock)completion callback:(IDBlock_id)callback;

/**
 *  使用present弹出viewController
 *
 *  @param viewController viewController
 *  @param animated       是否使用动画，默认为YES
 *  @param completion     present完成时执行的block
 */
- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(VoidBlock)completion;

/**
 *  参见dismissViewModelAnimated:completion:
 */
- (void)dismissViewModel;

/**
 *  参见dismissViewModelAnimated:completion:
 *
 *  @param animated 是否动画
 */
- (void)dismissViewModelAnimated:(BOOL)animated;

/**
 *  隐藏viewModel
 *
 *  @param animated   是否使用动画，默认为YES
 *  @param completion dismiss完成时执行的block
 */
- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;


// 重设window的rootViewController
- (void)resetRootViewController:(UIViewController *)rootViewController;

@end

@interface UINavigationController (YFBStatusBarStyleAdditions)

@end

@interface UIViewController (YFBNavigationBarHiddenAdditions)

@property (assign, nonatomic) BOOL yfb_prefersNavigationBarHidden;


@end


