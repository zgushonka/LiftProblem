//
//  Human.m
//  LiftProblem
//
//  Created by zgushonka on 3/2/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import "Human.h"
#import "HouseMD.h"

#include <stdlib.h>


@interface Human ()

@property (nonatomic, readwrite) NSUInteger sourceFloor;
@property (nonatomic, readwrite) NSUInteger targetFloor;

@property (nonatomic) NSUInteger createdAt;
@property (nonatomic) NSUInteger enteredLiftAt;
@property (nonatomic) NSUInteger exitedLiftAt;

@end

@implementation Human

- (instancetype)initInHouse:(HouseMD *)house {
    self = [self init];
    if (self) {
        int maxFloor = (int)house.numberOfFloors;
        self.sourceFloor = arc4random_uniform(maxFloor);
        
        do {
            int targetFloor = arc4random_uniform(maxFloor);
            self.targetFloor = targetFloor;
        } while (self.targetFloor == self.sourceFloor);
        
        self.createdAt = house.currentStep;        
        self.enteredLiftAt = 0;
        self.exitedLiftAt = 0;
    }
    return self;
}

//- (void)enterToLiftAt:(NSUInteger)step {
//    NSAssert(self.enteredLiftAt == 0, @"Human already in Lift");
//    self.enteredLiftAt = step;
//}

- (void)transferedAt:(NSUInteger)step {
    NSAssert(self.exitedLiftAt == 0, @"Human already left Lift");
    self.exitedLiftAt = step;
}

- (NSUInteger)transferTime {
    NSAssert( self.exitedLiftAt != 0, @"Human didn't get to the target floor");
    NSUInteger transferTime = self.exitedLiftAt - self.createdAt;
    return transferTime;
}

@end
