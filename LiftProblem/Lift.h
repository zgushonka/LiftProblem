//
//  Lift.h
//  LiftProblem
//
//  Created by zgushonka on 3/2/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HouseMD;
@class Human;
@class LiftBrain;

@interface Lift : NSObject

@property (nonatomic, weak) HouseMD* house;
@property (nonatomic, strong) NSMutableArray *peopleInLift;
@property (nonatomic, strong, readonly) LiftBrain *liftBrain;

- (instancetype)initWithHouse:(HouseMD *)house;

- (void)addHumanInLift:(Human *)newHuman;
- (void)addRequest:(NSUInteger)requestFloor;
- (void)performStep;

- (NSUInteger)currentFloor;

//  for lift brain
- (NSUInteger)maxFloor;

@end
