//
//  RXTask.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXTask.h"
#import "RXTimedTask.h"
#import "RXPatient.h"
#import "RXTaskDescriptor.h"

@implementation RXTask

+ (NSArray *)buildTaskWithDescriptors:(NSArray *)descriptors forPatient:(RXPatient *)patient {
    RXTimedTask *task = [[RXTimedTask alloc] init];
    RXTaskDescriptor *lastTypeDescriptor;
    
    task.patient = patient;
    
    for (RXTaskDescriptor *descriptor in descriptors) {
        lastTypeDescriptor = descriptor;
    }
    
    task.task = lastTypeDescriptor.name;
    task.type = lastTypeDescriptor.type;
    task.completed = NO;
    task.taskTime = [NSDate date];
    
    return [NSArray arrayWithObject:task];
}

@end
