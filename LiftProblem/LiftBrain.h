//
//  LiftBrain.h
//  LiftProblem
//
//  Created by zgushonka on 3/3/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Lift;

typedef enum : NSUInteger {
    LiftWait,
    LiftGoUp,
    LiftGoDown,
    LiftOpenDoor
} LiftAction;


@interface LiftBrain : NSObject

@property (nonatomic, readonly) LiftAction currentAction;
@property (nonatomic, readonly) NSUInteger currentFloor;
@property (nonatomic, strong, readonly) NSMutableSet *reqests;

- (instancetype)initWithLift:(Lift *)lift;

- (void)addRequest:(NSUInteger)request;
- (LiftAction)generteNextAction;
@end
