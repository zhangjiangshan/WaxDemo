//
//  LuaHelper.m
//  LuaTest
//
//  Created by zjs on 14-7-4.
//  Copyright (c) 2014年 zjs. All rights reserved.
//

#import "LuaHelper.h"
#import "wax.h"
#import "wax_http.h"
#import "wax_json.h"
#import "wax_xml.h"
#import "lauxlib.h"
#import "lobject.h"
#import "lualib.h"
@implementation LuaHelper

static BOOL isWaxRun = NO;
//+ (id)sharedInstance
//{
//    NSLog(@"sss");
//    static id helper = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        helper = [[self alloc] init];
//    });
//    return helper;
//}

+ (BOOL)runLua:(NSString *)path
{
    if (isWaxRun == NO) {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *pp = [[NSString alloc ] initWithFormat:@"%@/?.lua;%@/?/init.lua;", doc, doc];
        setenv(LUA_PATH, [pp UTF8String], 1);
        
        wax_start("", luaopen_wax_http, luaopen_wax_json, luaopen_wax_xml, nil);
        isWaxRun = YES;
    }
    
    BOOL flag = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (!flag) {
        return NO;
    }
    
    flag = luaL_dofile(wax_currentLuaState(), [path UTF8String]);
    if (flag != 0) {
        fprintf(stderr, "Error opening wax scripts: %s\n", lua_tostring(wax_currentLuaState(), -1));
    }
    return flag;
}

+ (void)exitLua
{
    wax_end();
    isWaxRun = NO;
}

@end
