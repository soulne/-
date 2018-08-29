//
//  YFBAthleticsViewModel.h
//  YFB
//
//  Created by yangfubin on 2018/8/29.
//  Copyright © 2018年 construction. All rights reserved.
//

#import "YFBViewModel.h"

@interface YFBAthleticsViewModel : YFBViewModel

@property (nonatomic, strong) NSArray *teamAinputDataSource;
@property (nonatomic, strong) NSArray *teamBinputDataSource;

@property (nonatomic, strong) NSArray *teamAoutputDataSource;
@property (nonatomic, strong) NSArray *teamBoutputDataSource;

- (NSDictionary *)viewModelViewMappings;

@end
