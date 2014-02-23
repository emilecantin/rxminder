//
//  RXWebService.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXWebService.h"

@implementation RXWebService

//+ (CKWebRequest*)requestForSearchResultCount {
//    CKWebSource *source = [CKWebSource webSource];
//    source.requestBlock = ^(NSRange range) {
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", [MBWebService baseUrl], @"publications/featured"]];
//        
//        CKWebRequest* request = [CKWebRequest requestForObjectsWithUrl:url
//                                                                params:nil
//                                                                  body:nil
//                                              mappingContextIdentifier:@"$MBBook"
//                                                      transformRawData:^NSArray*(id data) {
//                                                          NSDictionary* dico = [NSDictionary dictionaryWithDictionary:data];
//                                                          
//                                                          NSArray* results = [dico objectForKey:@"publications"];
//                                                          
//                                                          return results;
//                                                      }
//                                                            completion:^(NSArray *objects) {
//                                                                MBMediaRepository *repo = [[MBApplicationState sharedInstance] mediaRepository];
//                                                                for (MBBook *book in objects) {
//                                                                    [repo updatePropertiesForBook:book];
//                                                                }
//                                                            }
//                                                                 error:^(id value, NSHTTPURLResponse *response, NSError *error) {
//                                                                     //NSLog(error.description);
//                                                                 }];
//        
//        [request setValue:[NSString stringWithFormat:@"api_key=%@", [MBWebService apiKey]] forHTTPHeaderField:@"Authorization"];
//        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        
//        return request;
//    };
//    
//    return source;
//}
//

@end
