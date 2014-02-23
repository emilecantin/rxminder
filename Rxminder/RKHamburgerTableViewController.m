//
//  RKHamburgerTableViewController.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RKHamburgerTableViewController.h"
#import "RXApplicationState.h"
#import "RXLocalPatientSource.h"
#import "RXPatient.h"


@interface RKHamburgerTableViewController ()

@property(nonatomic, strong) CKArrayCollection *patientCollection;

@end

@implementation RKHamburgerTableViewController

#pragma mark ViewController Life Cycle

- (void)postInit{
    [super postInit];
    [self setupForm];
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

#pragma mark Initializing Form

- (void)setupForm{
    [self clear];
    [self setAutoFetchCollections:NO];
    
    __unsafe_unretained RKHamburgerTableViewController *bself = self;
    CKCollectionCellControllerFactory *factory = [CKCollectionCellControllerFactory factory];
    
    [factory addItemForObjectOfClass:[RXPatient class] withControllerCreationBlock:^CKCollectionCellController *(id object, NSIndexPath *indexPath){
        CKTableViewCellController *cell = [bself cellControllerForPatient:object];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }];
    
    self.patientCollection = [CKArrayCollection collectionWithFeedSource:[RXLocalPatientSource feedSource]];
    
    CKFormBindedCollectionSection *section = [CKFormBindedCollectionSection sectionWithCollection:self.patientCollection factory:factory];
    
    [self addSections:@[ section ]];
}

- (CKTableViewCellController *)cellControllerForPatient:(RXPatient *)patient {
    NSString *title = [NSString stringWithFormat:@"Patient %@ - %@", patient.bed, patient.initials];
    return [CKTableViewCellController cellControllerWithTitle:title action:^(CKTableViewCellController *controller) {
        [[RXApplicationState sharedInstance] setIsHamburgerOpen:NO];
        [[RXApplicationState sharedInstance] setSelectedPatient:patient];
    }];
}

#pragma mark Setup MVC and bindings

- (void)setupBindings{
    //TODO : Setup Views and bindings
}

@end
