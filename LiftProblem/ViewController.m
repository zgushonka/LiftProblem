//
//  ViewController.m
//  LiftProblem
//
//  Created by zgushonka on 3/2/15.
//  Copyright (c) 2015 zgushonka. All rights reserved.
//

#import "ViewController.h"

#define STEP_TIME 0.001

@interface ViewController ()

@property (nonatomic, strong) Statistics *statistics;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.statistics = [Statistics sharedStatistics];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self performStep];
    [self showStatistic];
}

- (void)performStep {
    [self.house performStep];
    [self performSelector:@selector(performStep) withObject:self afterDelay:STEP_TIME];
}

- (void)showStatistic {
    [self.statistics showTransferDelayBySourceFloor];
    [self performSelector:@selector(showStatistic) withObject:self afterDelay:2];
}

@end
