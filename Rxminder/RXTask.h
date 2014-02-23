//
//  RXTask.h
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RXPatient;

@interface RXTask : NSObject

@property(nonatomic, strong) RXPatient *patient;
@property(nonatomic, strong) NSString *task;
@property(nonatomic, strong) NSArray *snooze;
@property(nonatomic, strong) NSString *type;
@property(nonatomic, assign) BOOL completed;

+ (NSArray *)buildTaskWithDescriptors:(NSArray *)descriptors forPatient:(RXPatient *)patient;

@end
