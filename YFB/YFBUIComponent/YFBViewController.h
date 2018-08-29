//
//  YFBViewController.h
//  YFB
//
//  Created by wood on 2018/5/22.
//  Copyright © 2018年 construction. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFBViewProtocol.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface YFBViewController : UIViewController <YFBViewProtocol>

/**
 MVVM中viewModel
 */
@property (strong, nonatomic) id viewModel;

@end
