//
//  RXPatientSplitController.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXPatientSplitController.h"
#import "RXPatientsController.h"
#import "RXTaskListTableViewController.h"
#import "RXApplicationState.h"
#import "RXTaskCreateCollectionController.h"
#import "RXPatient.h"

@interface RXPatientSplitController ()

@end

@implementation RXPatientSplitController

#pragma mark ViewController Life Cycle

- (void)postInit{
    [super postInit];
    [self setupSubViewControllers];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self beginBindingsContextByRemovingPreviousBindings];
    [self setupBindings];
    [self endBindingsContext];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self clearBindingsContext];
}

#pragma mark Initializing View Controller

- (void)setupSubViewControllers{
    self.orientation = CKSplitViewOrientationVertical;
    
    NSArray* viewControllers = @[
                                 [RXPatientsController controller],
                                 [RXTaskListTableViewController controller]
    ];
    
    self.viewControllers = viewControllers;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStyleBordered block:^{
        CKCollection *collection = [CKArrayCollection collectionWithObjectsFromArray:[[[RXApplicationState sharedInstance] selectedPatient] taskDescriptors]];
        CKViewController *newTaskController = [RXTaskCreateCollectionController controllerWithCollection:collection];
        
        [[RXApplicationState sharedInstance] setPatientReturnController:self];
        [self.navigationController pushViewController:newTaskController animated:YES];
    }];
    
    right.name = @"add";
    self.rightButton = right;
}

#pragma mark Setup MVC and bindings

- (void)setupBindings{
    //TODO : Setup Views and bindings
}

@end
