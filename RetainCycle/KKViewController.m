//
//  KKViewController.m
//  RetainCycle
//
//  Created by Konstantin Koval on 15/03/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

#import "KKViewController.h"
#import "KKObject.h"
#import "KKLeakObject.h"

@interface KKViewController ()

@end

@implementation KKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self testLocalObject];
    [self testCocoaBlocks];
    [self testSelfCopyBlocks];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testLocalObject
{
    NSLog(@"\n Start Testing local variables with string references");

    // these 2 object are never released.
    KKObject *one = [KKObject new];
    KKObject *two = [KKObject new];
    one.object = two;
    two.object = one;
    
    NSLog(@"Retain count of one is %ld", CFGetRetainCount((__bridge CFTypeRef)(one)));
}

#pragma mark - Cocoa and Block

- (void)testCocoaBlocks
{
    [self testSelf];
    [self testHiddenSelf];
    [self testSelfInNSOperation];
}

- (void)testSelf
{
    NSLog(@"\n Start Testing Self in Cocoa block");
    KKObject *object = [KKObject new];
    [object testSelfInCocoaBlocks];
    NSLog(@"Retain count after testSelfInCocoaBlocks is %ld", CFGetRetainCount((__bridge CFTypeRef)(object)));
}

- (void)testHiddenSelf
{
    NSLog(@"\n Start Testing hidden Self in Cocoa block");
    KKObject *object = [KKObject new];
    [object testHiddenSelfInCocoaBlocks];
    NSLog(@"Retain count after testHiddenSelfInCocoaBlocks is %ld", CFGetRetainCount((__bridge CFTypeRef)(object)));
}

- (void)testSelfInNSOperation
{
    NSLog(@"\n Start Testing NSoperation Self in Cocoa block");
    KKObject *object = [KKObject new];
    [object testSelfInCocoaBlocks];
    NSLog(@"Retain count after testSelfInNSOperation is %ld", CFGetRetainCount((__bridge CFTypeRef)(object)));

}

#pragma mark - Test self in Blocks that are assing to copy property
- (void)testSelfCopyBlocks
{
    [self testStrongSelfInBlock];
    [self testStrongSelfInBlockWithClear];
    [self testWeakSelfInBlock];
}

- (void)testStrongSelfInBlock
{
    NSLog(@"\n Start Testing testStrongSelfInBlock");
    KKLeakObject *object = [KKLeakObject new];
    [object testSelfInBlock];
    NSLog(@"Retain count after testSelfInBlock is %ld", CFGetRetainCount((__bridge CFTypeRef)(object)));
}

- (void)testStrongSelfInBlockWithClear
{
    NSLog(@"\n Start Testing testStrongSelfInBlockWithClear");
    KKLeakObject *object = [KKLeakObject new];
    [object testClearSelfInBlock];
    NSLog(@"Retain count after testClearSelfInBlock is %ld", CFGetRetainCount((__bridge CFTypeRef)(object)));
}

- (void)testWeakSelfInBlock
{
    NSLog(@"\n Start Testing testWeakSelfInBlock");
    KKLeakObject *object = [KKLeakObject new];
    [object testWeakSelfInBlock];
    NSLog(@"Retain count after testWeakSelfInBlock is %ld", CFGetRetainCount((__bridge CFTypeRef)(object)));
}

@end
