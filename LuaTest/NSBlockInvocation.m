//
//  NSBlockInvocation.m
//  LuaTest
//
//  Created by zjs on 14-7-15.
//  Copyright (c) 2014年 zjs. All rights reserved.
//

#import "NSBlockInvocation.h"

@implementation NSBlockInvocation

+ (NSBlockInvocation *)invocationWithBlock:(void(^)(id object))block
{   NSBlockInvocation * invo = [[NSBlockInvocation alloc] init];
    [invo setBlock:block];
    return invo;
}

- (void)invoke
{
    self.block(nil);
}

- (void)invoke:(id)anObject
{
    self.block(anObject);
}

@end
