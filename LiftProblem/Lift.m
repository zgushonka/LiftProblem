//
//  Lift.m
//  LiftProblem
//
//  Created by zgushonka on 3/2/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import "Lift.h"
#import "HouseMD.h"
#import "Human.h"
#import "LiftBrain.h"
#import "Statistics.h"

@interface Lift () {
    NSUInteger highestTargetFloor;
    NSUInteger lowestTargetFloor;
}
@property (nonatomic) NSUInteger currentFloor;

@property (nonatomic, strong, readwrite) LiftBrain *liftBrain;
@end


@implementation Lift

- (instancetype)initWithHouse:(HouseMD *)house {
    self = [super init];
    if (self) {
        self.house = house;
        self.liftBrain = [[LiftBrain alloc] initWithLift:self];
        self.peopleInLift = [NSMutableArray array];
    }
    return  self;
}

- (void)performStep {
    LiftAction nextAction = [self.liftBrain generteNextAction];
    [Statistics showLiftAction:nextAction];
    switch (nextAction) {
        case LiftWait:
            return;
            break;
        case LiftGoUp:
            return;
            break;
        case LiftGoDown:
            return;
            break;
        case LiftOpenDoor: {
            [self popPeopleFromLift];
            [self putPeopleToLift];
        }
            break;
        default:
            assert(@"Error: wrong lift state");
            break;
    }
}


#pragma mark - Put People in lift
- (void)putPeopleToLift {
    NSMutableArray *peopleOnCurrentFloor = [self.house.peopleOnFloors objectAtIndex:self.liftBrain.currentFloor];
    for (Human *human in peopleOnCurrentFloor) {
        [self addHumanInLift:human];
    }
    [peopleOnCurrentFloor removeAllObjects];
}

- (void)addHumanInLift:(Human *)newHuman {
    [self.peopleInLift addObject:newHuman];
    [self addRequest:newHuman.targetFloor];     // the human pressed target button in the lift
}

- (void)addRequest:(NSUInteger)requestFloor {
    [self.liftBrain addRequest:requestFloor];
}


#pragma mark - Pop People in lift
- (void)popPeopleFromLift {
    NSArray *peopleInLift = [self.peopleInLift copy];
    for (Human *human in peopleInLift) {
        if (human.targetFloor == self.currentFloor) {
            [self.house humanGetToTargetFloor:human];
            [self.peopleInLift removeObject:human];
        }
    }
}


#pragma mark - statictics
- (NSUInteger)currentFloor {
    return self.liftBrain.currentFloor;
}


#pragma mark - Lift Brains
- (NSUInteger)maxFloor {
    return self.house.maxFloor;
}

@end
