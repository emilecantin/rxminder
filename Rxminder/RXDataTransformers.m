//
//  RXDataTransformers.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXDataTransformers.h"

@implementation RXDataTransformers

+ (id)transformTaskDescriptors:(id)value error:(NSError **)error {
    if(![value isKindOfClass:[NSString class]]){
        *error = [NSError errorWithDomain:@"RXDataTransformers" code:0 userInfo:nil];
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZ"];
 
    return [formatter dateFromString:value];
}

@end
