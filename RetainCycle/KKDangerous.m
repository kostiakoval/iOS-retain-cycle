//
//  KKDangerous.m
//  RetainCycle
//
//  Created by Konstantin Koval on 22/03/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

#import "KKDangerous.h"
typedef void(^KKDangerousBlock)();


@interface KKDangerous ()
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation KKDangerous

- (void)testNotificationCenterWithMainQueue
{
    [[NSNotificationCenter defaultCenter] addObserverForName:@"not"
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
        [self doSomethingWithCat:@"Noty cat"];
    }];
}

- (void)testNotificationCenterWithBackgroundQueue
{
    self.queue = [NSOperationQueue new];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"not" object:nil queue:self.queue usingBlock:^(NSNotification *note) {
        [self doSomethingWithCat:@"Back cat"];
    }];
}

- (void)testNotificationCenterWithSelectors
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observe:) name:@"not" object:nil];
}

- (void)observe:(NSNotification *)aNotification
{
    [self doSomethingWithCat:@"Selector cat"];
}

- (void)testStroringBlocks
{
    self.array = [NSMutableArray array];
    KKDangerousBlock block = ^{
        [self doSomethingWithCat:@"Miau"];
    };
    [self.array addObject:block];
}
@end
