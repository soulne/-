//
//  YFBGlobaleConfig.m
//  YFB
//
//  Created by wood on 2018/5/22.
//  Copyright © 2018年 construction. All rights reserved.
//

#import <Foundation/Foundation.h>

// ==================================================
// =================== 服务器根地址 ===================
// ==================================================
#pragma mark -  服务器根地址

#ifdef RELEASE
	#define MACRO_BASE_URL @"https://api.cixiaotong.com/"   	// 生产环境
#elif ENTERPRISE
	#define MACRO_BASE_URL @"https://enpr.cixiaotong.com/"		// 大企业环境
#elif DEVELOPE
	#define MACRO_BASE_URL @"https://dev.cixiaotong.com/"		// 开发环境
#elif BETA
	#define MACRO_BASE_URL @"https://test.cixiaotong.com/"		// 测试环境
#endif

/// 服务器地址
NSString * const YFB_BASE_URL = MACRO_BASE_URL;
