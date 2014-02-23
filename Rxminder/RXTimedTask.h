//
//  RXTimedTask.h
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXTask.h"

@interface RXTimedTask : RXTask

@property(nonatomic, strong) NSDate *taskTime;

@end
