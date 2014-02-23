//
//  RXPatientsController.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXPatientsController.h"
#import "RXTaskCreateCollectionController.h"
#import "RXApplicationState.h"
#import "RXPatient.h"

@interface RXPatientsController ()

@end

@implementation RXPatientsController

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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.title = [NSString stringWithFormat:@"Patient - %@", [[[RXApplicationState sharedInstance] selectedPatient] initials]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self clearBindingsContext];
}

#pragma mark Initializing View Controller

- (void)setupViewController{
    
    
}

#pragma mark Setup MVC and bindings

- (void)setupBindings{
    RXPatient *patient = [[RXApplicationState sharedInstance] selectedPatient];
    __unsafe_unretained RXPatientsController *bself = self;
    
    [patient bind:@"bed" executeBlockImmediatly:YES withBlock:^(id value) {
        UILabel *label = [bself.view viewWithKeyPath:@"numberLabelInfo"];
        label.text = value;
    }];
    [patient bind:@"initials" executeBlockImmediatly:YES withBlock:^(id value) {
        UILabel *label = [bself.view viewWithKeyPath:@"initialsLabelInfo"];
        label.text = value;
    }];
    [patient bind:@"age" executeBlockImmediatly:YES withBlock:^(id value) {
        UILabel *label = [bself.view viewWithKeyPath:@"ageLabelInfo"];
        label.text = value;
    }];
    [patient bind:@"weight" executeBlockImmediatly:YES withBlock:^(id value) {
        UILabel *label = [bself.view viewWithKeyPath:@"weightLabelInfo"];
        label.text = value;
    }];
    
    [patient bind:@"diagnostic" executeBlockImmediatly:YES withBlock:^(id value) {
        UILabel *label = [bself.view viewWithKeyPath:@"diagnosticView.diagnosticInfo"];
        label.text = value;
    }];
}

@end
