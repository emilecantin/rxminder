//
//  RXTaskTimeDescriptor.h
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXTaskTimeDescriptor : NSObject

@property(nonatomic, strong) NSDate *firstTaskTime;
@property(nonatomic, assign) NSTimeInterval recurringTimeInterval;
@property(nonatomic, assign) NSInteger recurringAmount;

@end
