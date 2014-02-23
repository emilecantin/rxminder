//
//  RXTimeDescriptorController.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXTimeDescriptorController.h"
#import "RXTaskDescriptor.h"
#import "RXTask.h"
#import "RXApplicationState.h"

@interface RXTimeDescriptorController ()

@end

@implementation RXTimeDescriptorController

#pragma mark ViewController Life Cycle

- (void)postInit{
    [super postInit];
    [self setupViewController];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self beginBindingsContextByRemovingPreviousBindings];
    [self setupBindings];
    [self endBindingsContext];
    
    self.rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered block:^{
        [self.navigationController popToViewController:[[RXApplicationState sharedInstance] patientReturnController] animated:YES];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self clearBindingsContext];
}

#pragma mark Initializing View Controller

- (void)setupViewController{
    //TODO : Setup View Controller
}

#pragma mark Setup MVC and bindings

- (void)setupBindings{
    //TODO : Setup Views and bindings
    UIButton *button = [self.view viewWithKeyPath:@"doneButton"];
    
    [button bindEvent:UIControlEventTouchUpInside executeBlockImmediatly:NO withBlock:^{
        NSArray *descriptors = [[RXApplicationState sharedInstance] buildingTaskDescriptors];
        NSArray *tasks = [RXTask buildTaskWithDescriptors:descriptors forPatient:[[RXApplicationState sharedInstance] selectedPatient]];
        
        [[RXApplicationState sharedInstance] addTasksToTimedTaskList:tasks];
        
        [self.navigationController popToViewController:[[RXApplicationState sharedInstance] patientReturnController] animated:YES];
    }];
}

@end
