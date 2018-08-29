//
//  YFBApplication.m
//  YFB
//
//  Created by yangfubin on 2018/5/23.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBApplication.h"
#import "YFBRoute.h"
#import "YFBRouter.h"
#import <objc/runtime.h>

static void *NavigationControllersKey = &NavigationControllersKey;

@implementation YFBApplication

+(YFBApplication *)sharedApplication{
    static YFBApplication *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YFBApplication alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}


#pragma mark - lifecycle

- (BOOL)application:(id<YFBApplicationDelegate>)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    uiApplication = application;
    return YES;
}

- (void)pushNavigationController:(UINavigationController *)navigationController {
    NSMutableArray *navigationControllers = objc_getAssociatedObject(self, NavigationControllersKey);
    
    if (navigationControllers == nil) {
        navigationControllers = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, NavigationControllersKey, navigationControllers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController {
    NSMutableArray *navigationControllers = objc_getAssociatedObject(self, NavigationControllersKey);
    UINavigationController *navigationController = navigationControllers.lastObject;
    [navigationControllers removeLastObject];
    return navigationController;
}

- (UINavigationController *)topNavigationController {
    NSMutableArray *navigationControllers = objc_getAssociatedObject(self, NavigationControllersKey);
    return navigationControllers.lastObject;
}

- (UINavigationController *)bottomNavigationController {
    NSMutableArray *navigationControllers = objc_getAssociatedObject(self, NavigationControllersKey);
    return navigationControllers.firstObject;
}

- (void)removeAllNavigationControllers {
    NSMutableArray *navigationControllers = objc_getAssociatedObject(self, NavigationControllersKey);
    
    NSArray *enumArray = navigationControllers.copy;
    for (UINavigationController *nav in enumArray) {
        if (nav.presentedViewController) {
            [nav dismissViewControllerAnimated:NO completion:^{
                [navigationControllers removeObject:nav];
                [nav.view removeFromSuperview];
            }];
        } else {
            [navigationControllers removeObject:nav];
        }
    }
}

- (void)pushViewModelWithRoute:(NSString *)route {
    [self pushViewModelWithRoute:route params:nil animated:YES callback:nil];
}

- (void)pushViewModelWithRoute:(NSString *)route params:(id)params {
    [self pushViewModelWithRoute:route params:params animated:YES callback:nil];
}

- (void)pushViewModelWithRoute:(NSString *)route params:(id)params animated:(BOOL)animated {
    [self pushViewModelWithRoute:route params:params animated:animated callback:nil];
}

- (void)pushViewModelWithRoute:(NSString *)route params:(id)params animated:(BOOL)animated callback:(IDBlock_id)callback {
    NSMutableArray *navigationControllers = objc_getAssociatedObject(self, NavigationControllersKey);
    
    YFBRoute *yfbRoute = [YFBRoute routeFromString:route];
    YFBRouter *yfbRouter = [YFBRouter sharedRouter];
    
    UIViewController *viewController = [yfbRouter viewControllerWithRoute:yfbRoute params:params callback:callback];
    [navigationControllers.lastObject pushViewController:viewController animated:animated];
}

- (void)popViewModel {
    [self popViewModelAnimated:YES step:1];
}

- (void)popViewModelAnimated:(BOOL)animated {
    [self popViewModelAnimated:animated step:1];
}

- (void)popViewModelAnimated:(BOOL)animated step:(NSUInteger)step {
    NSMutableArray *navigationControllers = objc_getAssociatedObject(self, NavigationControllersKey);
    
    NSArray *viewControllers = [navigationControllers.lastObject viewControllers];
    
    if (step <= viewControllers.count - 1) {
        UIViewController *viewController = [viewControllers objectAtIndex:viewControllers.count - 1 - step];
        [navigationControllers.lastObject popToViewController:viewController animated:animated];
    }
}

- (void)popToRootViewModel {
    [self popToRootViewModelAnimated:YES];
}

- (void)popToRootViewModelAnimated:(BOOL)animated {
    NSMutableArray *navigationControllers = objc_getAssociatedObject(self, NavigationControllersKey);
    [navigationControllers.lastObject popToRootViewControllerAnimated:animated];
}

- (void)presentViewModelWithRoute:(NSString *)route {
    [self presentViewModelWithRoute:route params:nil animated:YES completion:nil callback:nil];
}

- (void)presentViewModelWithRoute:(NSString *)route params:(id)params {
    [self presentViewModelWithRoute:route params:params animated:YES completion:nil callback:nil];
}

- (void)presentViewModelWithRoute:(NSString *)route params:(id)params animated:(BOOL)animated {
    [self presentViewModelWithRoute:route params:params animated:animated completion:nil callback:nil];
}

- (void)presentViewModelWithRoute:(NSString *)route params:(id)params animated:(BOOL)animated completion:(VoidBlock)completion {
    [self presentViewModelWithRoute:route params:params animated:animated completion:completion callback:nil];
}

- (void)presentViewModelWithRoute:(NSString *)route params:(id)params animated:(BOOL)animated completion:(VoidBlock)completion callback:(IDBlock_id)callback {
    YFBRoute *yfbRoute = [YFBRoute routeFromString:route];
    YFBRouter *yfbRouter = [YFBRouter sharedRouter];
    
    UIViewController *viewController = [yfbRouter viewControllerWithRoute:yfbRoute params:params callback:callback];
    [self presentViewController:viewController animated:animated completion:completion];
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(VoidBlock)completion {
    NSMutableArray *navigationControllers = objc_getAssociatedObject(self, NavigationControllersKey);
    
    UINavigationController *presentingViewController = navigationControllers.lastObject;
    if ([viewController isKindOfClass:UINavigationController.class]) {
        [self pushNavigationController:(UINavigationController *)viewController];
    } else {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self pushNavigationController:navigationController];
        
    }
    
    [presentingViewController presentViewController:navigationControllers.lastObject animated:animated completion:completion];
}

- (void)dismissViewModel {
    [self dismissViewModelAnimated:YES completion:nil];
}

- (void)dismissViewModelAnimated:(BOOL)animated {
    [self dismissViewModelAnimated:animated completion:nil];
}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion {
    NSMutableArray *navigationControllers = objc_getAssociatedObject(self, NavigationControllersKey);
    [self popNavigationController];
    [navigationControllers.lastObject dismissViewControllerAnimated:animated completion:completion];
}

- (void)resetRootViewController:(UIViewController *)rootViewController{
    if(uiApplication==nil){
        NSLog(@"CApplication error: please run application:(id<CApplicationDelegate>)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions to set delegate!");
        return;
    }
    
    NSParameterAssert([rootViewController isKindOfClass:UINavigationController.class]);
    
    [self removeAllNavigationControllers];
    [self pushNavigationController:(UINavigationController *)rootViewController];
    
    [uiApplication window].rootViewController = rootViewController;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {

    return nil;
}

@end

@implementation UINavigationController (YFBStatusBarStyleAdditions)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(preferredStatusBarStyle);
        SEL swizzledSelector = @selector(mrc_preferredStatusBarStyle);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (!success) {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

- (UIStatusBarStyle)mrc_preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

@end

@implementation UIViewController (YFBNavigationBarHiddenAdditions)

- (BOOL)yfb_prefersNavigationBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setYfb_prefersNavigationBarHidden:(BOOL)yfb_prefersNavigationBarHidden {
    objc_setAssociatedObject(self, @selector(yfb_prefersNavigationBarHidden), @(yfb_prefersNavigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(yfb_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        BOOL success = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)yfb_viewWillAppear:(BOOL)animated {
    [self yfb_viewWillAppear:animated];
    if (![self isKindOfClass:[UINavigationController class]]) {
        [self.navigationController setNavigationBarHidden:self.yfb_prefersNavigationBarHidden animated:animated];
    }
}

@end
