//
//  NSBlockInvocation.h
//  LuaTest
//
//  Created by zjs on 14-7-15.
//  Copyright (c) 2014年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBlockInvocation : NSObject
@property (nonatomic,copy) void(^block)(id object);

+(NSBlockInvocation *)invocationWithBlock:(void(^)(id object))block;
- (void)invoke;
- (void)invoke:(id)anObject;

@end
