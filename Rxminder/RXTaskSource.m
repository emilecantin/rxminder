//
//  RXTaskSource.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXTaskSource.h"
#import "RXApplicationState.h"
#import "RXPatient.h"

@implementation RXTaskSource

-(BOOL)fetchRange:(NSRange)range{
    if ([super fetchRange:range]) {
        NSMutableArray *taskArray = [NSMutableArray array];
        NSArray *patients = [[[RXApplicationState sharedInstance] patients] allObjects];
        
        for (RXPatient *patient in patients) {
            [taskArray addObjectsFromArray:patient.tasks];
        }
        
        NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"taskTime" ascending:NO];
        NSArray *descriptors=[NSArray arrayWithObject: descriptor];
        [taskArray sortUsingDescriptors:descriptors];
        
        __unsafe_unretained RXTaskSource *bself = self;
        
        [self performBlock:^(void){
            [bself addItems:taskArray];
        } afterDelay:0.01];
        
        return YES;
    }
    
    return NO;
}

@end
