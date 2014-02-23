//
//  RXLocalPatientSource.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXLocalPatientSource.h"
#import "RXApplicationState.h"
#import "RXPatient.h"

@implementation RXLocalPatientSource

-(BOOL)fetchRange:(NSRange)range{
    if ([super fetchRange:range]) {
        //Loads the payload from the LocalApiResults.json file
        NSString* filePath = [[[NSBundle mainBundle]URLForResource:@"ServerResponse2" withExtension:@"json"]path];
        NSData* data = [NSData dataWithContentsOfFile:filePath];
        
        //Parse the json payload to get a dictionary
        NSDictionary* dico = [NSObject objectFromJSONData:data];
        CKAssert([[dico objectForKey:@"patients"]count] > 0,@"Invalid data format!");
        
        [[RXApplicationState sharedInstance] setShiftBegin:[dico objectForKey:@"date_begin" ]];
        [[RXApplicationState sharedInstance] setShiftEnd:[dico objectForKey:@"date_end" ]];
        
        //Gets the requested range objects from the dictionary
        NSArray* results = [dico objectForKey:@"patients"];
        NSInteger length = MIN([results count] - range.location,range.length);
        if(length <= 0){
            self.hasMore = NO;
            return NO;
        }
        
        NSArray* items = [results objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(range.location,(NSUInteger)length)]];
        
        //Transform the array of dictionaries to Model objects using the '$Model' mapping defined in Api.mapping.
        CKMappingContext* context =[CKMappingContext contextWithIdentifier:@"$PatientTaskDescriptors"];
        
        NSError* error = nil;
        NSArray* transformedItem = [context objectsFromValue:items ofClass:[RXPatient class] error:&error];
        [self addItems:transformedItem];
        
        [[RXApplicationState sharedInstance] setPatients:[CKArrayCollection collectionWithObjectsFromArray:transformedItem]];
        
        return YES;
    }
    
    return NO;
}

@end
