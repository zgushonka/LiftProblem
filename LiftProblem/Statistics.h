//
//  Statistics.h
//  LiftProblem
//
//  Created by zgushonka on 3/3/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HouseMD.h"
#import "Lift.h"
#import "LiftBrain.h"

@interface Statistics : NSObject

+ (instancetype)sharedStatistics;

+ (void)showTextHouseStatistic:(HouseMD *)house;
//+ (void)showLiftAction:(LiftAction)liftAction;

- (void)addHumanToStatistic:(Human *)human;
- (void)showTransferDelayBySourceFloor;
@end
