//
//  KKDangerous.h
//  RetainCycle
//
//  Created by Konstantin Koval on 22/03/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

#import "KKObject.h"

@interface KKDangerous : KKObject

- (void)testNotificationCenterWithSelectors;

- (void)testNotificationCenterWithMainQueue;
- (void)testNotificationCenterWithBackgroundQueue;

- (void)testStroringBlocks;

@end
