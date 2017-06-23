//
//  PthreadTools.m
//  ThreadDeno
//
//  Created by liicon on 2017/6/16.
//  Copyright © 2017年 max. All rights reserved.
//

#import "PthreadTools.h"

@implementation PthreadTools

- (instancetype)init{
    self = [super init];
    if (self) {
//        [self testGCD];
        [self testSemaphore];
    }
    return self;
}

- (void)testGCD{
    
    dispatch_queue_t aSerialQueue3 = dispatch_queue_create("com.test.serial.queue3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, aSerialQueue3, ^{
        NSLog(@"12");
    });
    dispatch_group_async(group, aSerialQueue3, ^{
        sleep(5);
        NSLog(@"1");
    });
    dispatch_group_async(group, aSerialQueue3, ^{
        sleep(2);
        NSLog(@"2");
    });
    
    dispatch_group_async(group, aSerialQueue3, ^{
        
        sleep(20);
        NSLog(@"14");
    });
    
    
    //监听一个group
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"13");
    });
    
    NSLog(@"3");

}


/**
 信号量控制并发
 */
- (void)testSemaphore{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    
    dispatch_queue_t aSerialQueue = dispatch_queue_create("com.test.serial.queue3", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t queue = dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(aSerialQueue, ^{
        
        for (int i = 0; i < 100; i ++) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_group_async(group, queue, ^{
                sleep(2);
                NSLog(@"add thread %d",i);
                dispatch_semaphore_signal(semaphore);
            });
        }
    });
}

@end
