//
//  LuaHelper.h
//  LuaTest
//
//  Created by zjs on 14-7-4.
//  Copyright (c) 2014年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LuaHelper : NSObject

+ (BOOL)runLua:(NSString *)path;

+ (void)exitAllLua;

@end
