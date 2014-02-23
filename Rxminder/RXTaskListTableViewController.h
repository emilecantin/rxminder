//
//  RXTaskListTableViewController.h
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import <AppCoreKit/AppCoreKit.h>
#import "ZUUIRevealController.h"

@interface RXTaskListTableViewController : CKFormTableViewController <ZUUIRevealControllerDelegate, UIGestureRecognizerDelegate>

@property(nonatomic, weak) ZUUIRevealController *revealController;
@property(nonatomic, strong) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;

@end
