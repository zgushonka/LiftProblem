//
//  HouseMD.h
//  LiftProblem
//
//  Created by zgushonka on 3/2/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Human.h"
#import "Lift.h"

@class Lift;

@interface HouseMD : NSObject

@property (nonatomic, strong) Lift *lift;
@property (nonatomic, readonly) NSUInteger currentStep;
@property (nonatomic, strong) NSArray *peopleOnFloors;

- (NSUInteger)numberOfFloors;
- (NSUInteger)maxFloor;

- (void)humanGetToTargetFloor:(Human *)human;

@end
