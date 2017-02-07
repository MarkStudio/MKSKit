//
//  MemoryWarningTest.m
//  Pods
//
//  Created by Mark Yang on 07/02/2017.
//
//

#import "MemoryWarningTest.h"
#import <UIKit/UIkit.h>

#ifndef __OPTIMIZE__
#define OPEN_MEMORY_WARNING_TEST YES    // 打开内存警告测试开关
#else 
#define OPEN_MEMORY_WARNING_TEST NO     // 关闭内存警告测试开关
#endif

@implementation MemoryWarningTest

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark -

- (void)simulateMemoryWarning
{
    if (OPEN_MEMORY_WARNING_TEST == NO) {
        return;
    }
    
    // this is a private API, just use in physic device
    SEL memoryWarning = @selector(_performMemoryWarning);
    [[UIApplication sharedApplication] performSelector:memoryWarning];
}//

@end
