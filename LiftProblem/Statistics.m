//
//  Statistics.m
//  LiftProblem
//
//  Created by zgushonka on 3/3/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import "Statistics.h"

@implementation Statistics

+ (void)showTextHouseStatistic:(HouseMD *)house {
    for (int i=house.maxFloor; i >= 0; i--) {
        NSArray *peopleOnCurrentFloor = (NSArray *)[house.peopleOnFloors objectAtIndex:i];
        NSUInteger peopleCountOnFloor = peopleOnCurrentFloor.count;
        NSUInteger peopleInLift = house.lift.peopleInLift.count;
        NSString *reqested = [house.lift.liftBrain.reqests containsObject:@(i)] ? @"*" : @" ";
        NSString *lift = (house.lift.currentFloor == i) ? [NSString stringWithFormat:@"X %lu", (unsigned long)peopleInLift] : @" ";
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

@end
