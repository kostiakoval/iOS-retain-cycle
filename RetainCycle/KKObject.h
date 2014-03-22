//
//  KKObject.h
//  RetainCycle
//
//  Created by Konstantin Koval on 15/03/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKObject : NSObject

@property (nonatomic, strong) KKObject *object;

- (void)testSelfInCocoaBlocks;
- (void)testHiddenSelfInCocoaBlocks;

- (void)testSelfInNSOperation;

@end
