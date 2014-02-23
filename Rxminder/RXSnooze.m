
//
//  RXSnooze.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXSnooze.h"

@implementation RXSnooze

+ (RXSnooze *)SnoozeWithMinutes:(NSInteger)minutes {
    RXSnooze *snooze = [[RXSnooze alloc] init];
    snooze.snoozeInterval = minutes * 60;

    return snooze;
}

@end
