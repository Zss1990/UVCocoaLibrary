// Copyright (c) 2011-2014, Zhejiang XXXX Technologies Co., Ltd. All rights reserved.
// --------------------------------------------------------------------------------
// UVUtils.h
//
// Project Code: UVCocoaLibrary
// Module Name:
// Date Created: 2013-11-19
// Author: selectersky/00891
// Description:工具函数类
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
//
#import <UIKit/UIKit.h>

/** 工具类
 
 使用示例：
 
        
 
 */
//@class UIViewController,NSObject;

@interface UVUtils : NSObject


//获取最顶层的viewcontroller
- (UIViewController *)topViewController;
- (NSBundle*)bundle;
@end
