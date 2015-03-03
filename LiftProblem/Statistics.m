//
//  Statistics.m
//  LiftProblem
//
//  Created by zgushonka on 3/3/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import "Statistics.h"
#import "HouseMD.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define numberOfFloors 8

@interface Statistics () {
    int humanTransferTime [numberOfFloors];
    int totalHumanOnFloor [numberOfFloors];
}

@end

@implementation Statistics

+ (instancetype)sharedStatistics {
    static Statistics *sharedStatistics = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStatistics = [[self alloc] init];
    });
    return sharedStatistics;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        for (int i=0; i < numberOfFloors; i++) {
            humanTransferTime[i] = 0;
            totalHumanOnFloor[i] = 0;
        }
    }
    return self;
}

+ (void)showTextHouseStatistic:(HouseMD *)house {
    for (int i=house.maxFloor; i >= 0; i--) {
        NSArray *peopleOnCurrentFloor = (NSArray *)[house.peopleOnFloors objectAtIndex:i];
        NSUInteger peopleCountOnFloor = peopleOnCurrentFloor.count;
        NSUInteger peopleInLift = house.lift.peopleInLift.count;
        NSString *reqested = [house.lift.liftBrain.reqests containsObject:@(i)] ? @"*" : @" ";
        NSString *liftString = house.lift.liftBrain.currentAction == LiftOpenDoor ? @"O" : @"X";
        NSString *lift = (house.lift.currentFloor == i) ? [NSString stringWithFormat:@"%@ %lu", liftString, (unsigned long)peopleInLift] : @" ";
        NSLog(@"floor %d: people: %lu requested:%@ - %@", i, (unsigned long)peopleCountOnFloor, reqested, lift);
    }
    NSLog(@"current Step - %lu", (unsigned long)house.currentStep);
}

+(void)showLiftAction:(LiftAction)liftAction {
    NSString *liftActionString = nil;
    switch (liftAction) {
        case LiftWait:
            liftActionString = @"LiftWait";
            break;
        case LiftGoUp:
            liftActionString = @"LiftGoUp";
            break;
        case LiftGoDown:
            liftActionString = @"LiftGoDown";
            break;
        case LiftOpenDoor:
            liftActionString = @"LiftOpenDoor";
            break;
            
        default:
            liftActionString = @"WTF";
            break;
    }
    NSLog(@"%@", liftActionString);
}

- (void)addHumanToStatistic:(Human *)human {
    humanTransferTime[human.sourceFloor] += human.transferTime;
    totalHumanOnFloor[human.sourceFloor]++;
}

- (void)showTransferDelayBySourceFloor {
    NSLog(@"\n");
//    HouseMD *house = ( (AppDelegate *)[UIApplication sharedApplication].delegate).house;
//    [Statistics showTextHouseStatistic:house];
    for (int i=numberOfFloors-1; i >= 0; i--) {
        float att = (float)humanTransferTime[i]/totalHumanOnFloor[i];
        NSLog(@"ATT floor %d: %f   total:%d", i, att, totalHumanOnFloor[i]);
    }
}


@end
