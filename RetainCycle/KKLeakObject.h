//
//  KKLeakObject.h
//  RetainCycle
//
//  Created by Konstantin Koval on 22/03/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

#import "KKObject.h"

@interface KKLeakObject : KKObject

- (void)testSelfInBlock;
- (void)testClearSelfInBlock;
- (void)testWeakSelfInBlock;

@end
