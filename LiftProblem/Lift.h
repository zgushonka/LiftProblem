//
//  Lift.h
//  LiftProblem
//
//  Created by zgushonka on 3/2/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HouseMD.h"
#import "Human.h"

@class HouseMD;

@interface Lift : NSObject

@property (nonatomic, weak) HouseMD* house;
@property (nonatomic, readonly) NSUInteger currentFloor;
@property (nonatomic, strong) NSMutableSet *peopleInLift;

- (instancetype)initWithHouse:(HouseMD *)house;
- (void)performStep;
- (void)addHumanInLift:(Human *)newHuman;

- (void)addRequest:(NSUInteger)requestFloor;

@end
