//
//  RXPatient.h
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXPatient : NSObject

@property(nonatomic, strong) NSString *initials;
@property(nonatomic, strong) NSString *age;
@property(nonatomic, strong) NSString *weight;
@property(nonatomic, strong) NSString *bed;
@property(nonatomic, strong) NSString *diagnostic;
@property(nonatomic, strong) NSString *description;
@property(nonatomic, strong) NSArray *taskDescriptors; //RXTaskDescriptor
@property(nonatomic, strong) NSArray *tasks; //RXTasks

@end
