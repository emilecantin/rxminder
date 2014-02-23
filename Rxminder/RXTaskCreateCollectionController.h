//
//  RXTaskCreateCollectionController.h
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import <AppCoreKit/AppCoreKit.h>

@interface RXTaskCreateCollectionController : CKCollectionViewLayoutController

+ (RXTaskCreateCollectionController *)controllerWithCollection:(CKCollection *)collection;
    
@end
