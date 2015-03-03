//
//  LiftBrain.m
//  LiftProblem
//
//  Created by zgushonka on 3/3/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import "LiftBrain.h"

const NSUInteger Ground_Floor = 0;

@interface LiftBrain () {
    BOOL goingUP;
    BOOL goingDown;
}

@property (nonatomic, strong) Lift *lift;
@property (nonatomic, strong, readwrite) NSMutableSet *reqests;
@property (nonatomic, readwrite) NSUInteger currentFloor;
@property (nonatomic) LiftAction currentAction;
@end


@implementation LiftBrain

- (instancetype)initWithLift:(Lift *)lift {
    self = [super init];
    if (self) {
        self.lift = lift;
        self.currentFloor = Ground_Floor;
        self.reqests = [NSMutableSet set];
        
        goingDown = NO;
        goingUP = NO;
    }
    return  self;
}

- (void)addRequest:(NSUInteger)requestFloor {
    [self.reqests addObject:@(requestFloor)];
}

- (LiftAction)generteNextAction {
    
    LiftAction lastAction = self.currentAction;
    LiftAction nextAction = lastAction;
    
    switch (lastAction) {
            
        case LiftWait:
            //  if request - choose direction and start moving
            if ([self requestExists]) {
                nextAction = [self startMove];
            }
            //  else keep waiting
            break;
            
        case LiftGoUp:
            self.currentFloor++;
            if ([self requestOnCurrentFloor]) {
                nextAction = LiftOpenDoor;
            }
            //  else keep moving up
            break;
            
        case LiftGoDown:
            self.currentFloor--;
            if ([self requestOnCurrentFloor]) {
                nextAction = LiftOpenDoor;
            }
            //  else keep moving down
            break;
            
        case LiftOpenDoor:
            //  if request - choose direction and start moving
            if ([self requestExists]) {
                
                BOOL startAfterWait = !goingUP && !goingDown;
                if (startAfterWait) {
                    nextAction = [self startMove];
                    break;
                }
                
                if (goingUP) {
                    if ([self needGoUp]) {
                        nextAction = LiftGoUp;
                        break;
                    } else {
                        if ([self needGoDown]) {
                            goingDown = YES;
                            goingUP = NO;
                            nextAction = LiftGoDown;
                            break;
                        }
                    }
                }
                
                if (goingDown) {
                    if ([self needGoDown]) {
                        nextAction = LiftGoDown;
                        break;
                    } else {
                        if ([self needGoUp]) {
                            goingUP = YES;
                            goingDown = NO;
                            nextAction = LiftGoUp;
                            break;
                        }
                    }
                }
            }
            else {
                nextAction = LiftWait;
                goingUP = NO;
                goingDown = NO;
            }
            break;
            
        default:
            break;
    }
    
    //  fulfil request and remove from list
    if (nextAction == LiftOpenDoor) {
        [self.reqests removeObject:@(self.currentFloor)];
    }
    
    self.currentAction = nextAction;
    return self.currentAction;
}

- (LiftAction)startMove {
    if ([self requestOnCurrentFloor]) {
        return LiftOpenDoor;
    }
    else if ([self needGoUp]) {
        goingUP = YES;
        goingDown = NO;
        return LiftGoUp;
    }
    else if ([self needGoDown]) {
        goingDown = YES;
        goingUP = NO;
        return LiftGoDown;
    }
    return LiftWait;
}

//  some button pressed
- (BOOL)requestExists {
    return (self.reqests.count > 0);
}

//  need open doors
- (BOOL)requestOnCurrentFloor {
    return [self.reqests containsObject:@(self.currentFloor)];
}

- (BOOL)needGoUp {
    //  there requests to higher floors
    for (NSNumber *requestFloor in self.reqests) {
        NSUInteger requestFloorInt = requestFloor.integerValue;
        if (requestFloorInt > self.currentFloor) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)needGoDown {
    //  there requests to lower floors
    for (NSNumber *requestFloor in self.reqests) {
        NSUInteger requestFloorInt = requestFloor.integerValue;
        if (requestFloorInt < self.currentFloor) {
            return YES;
        }
    }
    return NO;
}

@end
