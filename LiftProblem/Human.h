//
//  Human.h
//  LiftProblem
//
//  Created by zgushonka on 3/2/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Human : NSObject

@property (nonatomic, readonly) NSUInteger sourceFloor;
@property (nonatomic, readonly) NSUInteger targetFloor;

- (void)transferedAt:(NSUInteger)step;
- (NSUInteger)transferTime;

@end
