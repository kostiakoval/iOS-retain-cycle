//
//  KKObject.m
//  RetainCycle
//
//  Created by Konstantin Koval on 15/03/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

#import "KKObject.h"
#import <JRSwizzle.h>

@interface KKObject ()
{
    NSString *_aCat;
    NSOperationQueue *_backgroundQueue;
}

@end

@implementation KKObject

#pragma mark - Memory Log

+ (id)alloc
{
    NSLog(@"Alloc");
    return [super alloc];
}

- (void)dealloc
{
    NSLog(@"Dealloc");
}

#pragma mark - Self in block

- (void)doSomethingWithCat:(NSString *)aCat
{
    NSLog(@"A Cat %@", aCat);
}

- (void)testSelfInCocoaBlocks
{
    NSArray *cats = @[@"Smily", @"Garfild", @"Other cat"];
    NSLog(@"Retain count before block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));

    [cats enumerateObjectsUsingBlock:^(NSString *cat, NSUInteger idx, BOOL *stop) {
        [self doSomethingWithCat:cat];
    }];
    
    NSLog(@"Retain count after block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
}

- (void)testHiddenSelfInCocoaBlocks
{
    NSArray *cats = @[@"Smily", @"Garfild", @"Other cat"];
    NSLog(@"Retain count before block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
    
    [cats enumerateObjectsUsingBlock:^(NSString *cat, NSUInteger idx, BOOL *stop) {
        self->_aCat = cat;
        *stop = YES;
    }];
    
    NSLog(@"Retain count after block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
}

- (void)testSelfInNSOperation
{
    NSLog(@"Retain count before block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        [self doSomethingWithCat:@"My kitti"];
    }];
    NSLog(@"Retain count after block is %ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
}


@end
