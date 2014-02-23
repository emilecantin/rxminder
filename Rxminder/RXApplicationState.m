//
//  RXApplicationState.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXApplicationState.h"
#import "RXTaskDescriptor.h"
#import "RXPatient.h"

@implementation RXApplicationState

- (void)addTaskDescriptorToBuild:(RXTaskDescriptor *)descriptor {
    
    if (self.buildingTaskDescriptors == nil) {
        self.buildingTaskDescriptors = [NSMutableArray array];
    }
    
    [self.buildingTaskDescriptors addObject:descriptor];
}

- (void)eraseTaskDescriptorBuild {
    [self.buildingTaskDescriptors removeAllObjects];
}

- (void)addTasksToTimedTaskList:(NSArray *)tasks {
    if (self.timedTasks == nil) {
        self.timedTasks = [CKArrayCollection collection];
    }
    
    [self.timedTasks addObjectsFromArray:tasks];
}

- (void)setShiftBegin:(NSString *)shiftBegin {
    NSDate *date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZ"];
 
    date = [formatter dateFromString:shiftBegin];
    
    _shiftBegin = date;
}

- (void)setShiftEnd:(NSString *)shiftEnd {
    NSDate *date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZ"];
 
    date = [formatter dateFromString:shiftEnd];
    
    _shiftEnd = date;
}

- (RXPatient *)patientForTask:(RXTask *)task {
    for (RXPatient *patient in self.patients) {
        for (RXTask *task in patient.tasks) {
            if ([patient.tasks containsObject:task]) {
                return patient;
            }
        }
    }
    return nil;
}

@end
