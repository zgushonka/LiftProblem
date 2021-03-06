//
//  HouseMD.m
//  LiftProblem
//
//  Created by zgushonka on 3/2/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import "HouseMD.h"

const NSInteger numberOfFloors = 8; //  0 .. numberOfFloors-1
const NSInteger skipStep = 5; //  0 .. numberOfFloors-1


@interface HouseMD ()

@property (nonatomic, readwrite) NSUInteger currentStep;
@end


@implementation HouseMD

- (instancetype)init {
    self = [super init];
    if (self) {
        self.lift = [[Lift alloc] initWithHouse:self];
        self.currentStep = 0;
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i=0; i < numberOfFloors; i++) {
            tempArray[i] = [NSMutableArray array];
        }
        self.peopleOnFloors = tempArray;
    }
    return self;
}

- (void)performStep {
    NSLog(@"\n");
    [self generateNewPeople];
    [self.lift performStep];
    [Statistics showTextHouseStatistic:self];
    
    self.currentStep++;
    
}

- (void)generateNewPeople {
    if (self.currentStep%skipStep != 1) {
        return;
    }    
    
    //  generate human
    Human *newHuman = [[Human alloc] initInHouse:self];
    
    //  add him to corresponding floor
    NSMutableArray *peopleOnNewHumanFloor = [self.peopleOnFloors objectAtIndex:newHuman.sourceFloor];
    [peopleOnNewHumanFloor addObject:newHuman];
    
    //  add his request to the lift
    [self.lift addRequest:newHuman.sourceFloor];
}

- (void)humanGetToTargetFloor:(Human *)human {
    [human transferedAt:self.currentStep];
    //  add human to statistic
}

- (NSUInteger)maxFloor {
    return numberOfFloors - 1;
}

- (NSUInteger)numberOfFloors {
    return numberOfFloors;
}

@end
