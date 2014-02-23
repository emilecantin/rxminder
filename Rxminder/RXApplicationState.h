//
//  RXApplicationState.h
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppCoreKit/AppCoreKit.h>

@class RXPatient;
@class RXTask;
@class RXTaskDescriptor;

@interface RXApplicationState : NSObject

//App state
@property(nonatomic, assign) BOOL isHamburgerOpen;
@property(nonatomic, strong) RXPatient *selectedPatient;
@property(nonatomic, strong) CKViewController *patientReturnController;

//Local collections
@property(nonatomic, strong) CKArrayCollection *timedTasks;
@property(nonatomic, strong) CKArrayCollection *nonTimedTasks;

//Task creation display
@property(nonatomic, strong) CKArrayCollection *patients;
@property(nonatomic, strong) NSMutableArray *buildingTaskDescriptors;

//Shift state
@property(nonatomic, strong) NSDate *shiftBegin;
@property(nonatomic, strong) NSDate *shiftEnd;

- (void)addTaskDescriptorToBuild:(RXTaskDescriptor *)descriptor;
- (void)eraseTaskDescriptorBuild;

- (void)addTasksToTimedTaskList:(NSArray *)tasks;

- (RXPatient *)patientForTask:(RXTask *)task;

@end
