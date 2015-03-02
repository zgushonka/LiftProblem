//
//  Lift.m
//  LiftProblem
//
//  Created by zgushonka on 3/2/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import "Lift.h"

const NSUInteger Ground_Floor = 0;

@interface Lift () {
    BOOL goingUP;
    BOOL goingDown;
    
    NSUInteger highestTargetFloor;
    NSUInteger lowestTargetFloor;
}
@property (nonatomic, readwrite) NSUInteger currentFloor;

@property (nonatomic, strong) NSMutableSet *reqests;

@end


@implementation Lift

- (instancetype)initWithHouse:(HouseMD *)house {
    self = [super init];
    if (self) {
        goingDown = NO;
        goingUP = NO;
        
        highestTargetFloor = house.maxFloor;
        lowestTargetFloor = Ground_Floor;
        
        self.currentFloor = Ground_Floor;
        self.peopleInLift = [NSMutableSet set];
        self.reqests = [NSMutableSet set];
        self.house = house;
    }
    return  self;
}

- (void)addHumanInLift:(Human *)newHuman {
    if (newHuman) {
        [self.peopleInLift addObject:newHuman];
        [self addRequest:newHuman.targetFloor];     // the human pressed target button in the lift
    }
}

- (void)addRequest:(NSUInteger)requestFloor {
    [self.reqests addObject:@(requestFloor)];
}

- (void)performStep {
    [self popPeopleFromLift];
}

- (void)popPeopleFromLift {
    NSArray *peopleInLift = [self.peopleInLift copy];
    for (Human *human in peopleInLift) {
        if (human.targetFloor == self.currentFloor) {
            [self.house humanGetToTargetFloor:human];
            [self.peopleInLift removeObject:human];
        }
    }
    [self.reqests removeObject:@(self.currentFloor)];
}



//
//- (void)makeMove {
//    
//    NSAssert( !(goingDown && goingUP), @"Error: lift direction error at %@:%@:%d ", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__);
//    
//    if (goingUP) {
//        if (self.currentFloor >= highestTargetFloor) {
//            goingUP = NO;
//        } else {
//            self.currentFloor++;
//        }
//    }
//    
//    if (goingDown) {
//        if (self.currentFloor <= lowestTargetFloor) {
//            goingDown = NO;
//        } else {
//            self.currentFloor--;
//        }
//    }
//}
//
//- (void)performStep:(NSUInteger)step {
//    
//    BOOL needStop = NO;
//    for (Human *human in self.peopleInLift) {
//        needStop = human.targetFloor == self.currentFloor;
//        if (needStop) {
//            break;
//        }
//    }
//    
//    
//    if (needStop) {
//        for (Human *human in self.peopleInLift) {
//            human 
//        }
//        return; // waste step
//    }
//    
//    
//    
//    [self makeMove];
//}

@end
