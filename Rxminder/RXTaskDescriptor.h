//
//  RXTaskDescriptor.h
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXTaskDescriptor : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSArray *subtasks; //RXTaskDescriptors

@end
