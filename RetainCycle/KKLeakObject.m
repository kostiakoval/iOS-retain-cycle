//
//  KKLeakObject.m
//  RetainCycle
//
//  Created by Konstantin Koval on 22/03/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

#import "KKLeakObject.h"

typedef void(^KKBlock)();
@interface KKLeakObject()

@property (nonatomic, copy) KKBlock block;

@end

@implementation KKLeakObject

- (void)testSelfInBlock
{
    NSLog(@"Retain count before block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
    self.block = ^{
        [self doSomethingWithCat:@"Fat Cat"];
    };
    NSLog(@"Retain count after block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
- (void)testClearSelfInBlock
{
    NSLog(@"Retain count before block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
    self.block = ^{
        [self doSomethingWithCat:@"Fat Cat"];
    };
    self.block = nil;
    NSLog(@"Retain count after block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
}
#pragma clang diagnostic pop

// This methid will show warrning again because we have enabled warning again with "clang diagnostic pop" command
- (void)privateWarningTest
{
    self.block = ^{
        [self doSomethingWithCat:@"Fat Cat"];
    };
    self.block = nil;
}

- (void)testWeakSelfInBlock
{
    NSLog(@"Retain count before block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
    __weak typeof(self) weakSelf =  self;
    self.block = ^{
        [weakSelf doSomethingWithCat:@"Fat Cat"];
    };
    NSLog(@"Retain count after block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
}

- (void)testLeakWithCocoa
{
    NSLog(@"Retain count before block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));

    NSOperationQueue *queue = [NSOperationQueue new];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        if(operation.isCancelled)
        {
            NSLog(@"canceled");
        }
    }];
    [queue addOperation:operation];
    NSLog(@"Retain count after block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
}


@end
