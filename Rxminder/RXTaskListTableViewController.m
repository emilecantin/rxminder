//

//  RXTaskListTableViewController.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXTaskListTableViewController.h"
#import "RXApplicationState.h"
#import "RXLocalPatientSource.h"
#import "RXPatient.h"
#import "RXTimedTask.h"
#import "RXTaskSource.h"
#import "RXPatientSplitController.h"
#import "RXTaskListCellController.h"

@interface RXTaskListTableViewController ()

@property(nonatomic, strong) CKArrayCollection *patientCollection;

@end

@implementation RXTaskListTableViewController

#pragma mark ViewController Life Cycle

- (void)postInit{
    [super postInit];
    [self setupNavigationButtons];
    [self setupForm];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[RXApplicationState sharedInstance] setTimedTasks:[CKArrayCollection collectionWithFeedSource:[RXTaskSource feedSource]]];
    
    [self beginBindingsContextByRemovingPreviousBindings];
    [self setupBindings];
    [self endBindingsContext];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self clearBindingsContext];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.tableView.hidden = YES;
        self.navigationController.navigationBar.hidden = YES;
        CKImageView *image = [self.view viewWithKeyPath:@"fullDayView"];
        image.hidden = NO;
    } else {
        self.tableView.hidden = NO;
        self.navigationController.navigationBar.hidden = NO;
        CKImageView *image = [self.view viewWithKeyPath:@"fullDayView"];
        image.hidden = YES;
    }
}

#pragma mark Initializing Form

- (void)setupForm{
    __unsafe_unretained RXTaskListTableViewController* bself = self;
    CKCollectionCellControllerFactory* factory = [CKCollectionCellControllerFactory factory];
    
    [factory addItemForObjectOfClass:[NSObject class] withControllerCreationBlock:^CKCollectionCellController *(id object, NSIndexPath *indexPath) {
        CKTableViewCellController* cell = [bself tableViewCellControllerForTask:object indexPath:indexPath];
        
        return cell;
    }];
    
    CKFormBindedCollectionSection *section = [CKFormBindedCollectionSection sectionWithCollection:[CKArrayCollection collectionWithFeedSource:[RXTaskSource feedSource]]
                                                                                          factory:factory];
    NSArray* sections = @[ section ];
    
    [self addSections:sections];
}

- (CKTableViewCellController *)tableViewCellControllerForTask:(RXTimedTask *)task indexPath:(NSIndexPath *)indexPath {
    CKTableViewCellController *controller = [RXTaskListCellController cellControllerWithName:@"TaskCell" action:^(CKTableViewCellController *controller) {
        RXPatient *patient = [[RXApplicationState sharedInstance] patientForTask:task];
        [[RXApplicationState sharedInstance] setSelectedPatient:patient];
    }];
    controller.cellStyle = CKTableViewCellStyleCustomLayout;
    controller.value = task;
    
    __unsafe_unretained RXTaskListTableViewController *bself = self;
    
    [controller setSetupBlock:^(CKTableViewCellController *controller, UITableViewCell *cell) {
        [bself beginBindingsContextByRemovingPreviousBindings];
        
        CKImageView *image = [cell.contentView viewWithKeyPath:@"cellView"];
        NSString *imageName = [NSString stringWithFormat:@"tasks%d", indexPath.row % 3 + 1];
        [image setDefaultImage:[UIImage imageNamed:imageName]];
//        MBPageMarker *marker = (MBPageMarker *)controller.value;
//        
//        [marker bind:@"book.title" executeBlockImmediatly:YES withBlock:^(id value) {
//            UILabel *title = [cell.contentView viewWithKeyPath:@"markerBookTitle"];
//            title.text = (NSString *)value;
//        }];
//        
//        [marker bind:@"page" executeBlockImmediatly:YES withBlock:^(id value) {
//            NSUInteger page = [value unsignedIntegerValue];
//            UILabel *pageLabel = [cell.contentView viewWithKeyPath:@"markerBookPage"];
//            
//            if ([value integerValue] == 0) {
//                pageLabel.text = @"Cover Page";
//            } else {
//                pageLabel.text = [NSString stringWithFormat:@"Page %lu", (unsigned long)page];
//            }
//        }];
        
        [bself endBindingsContext];
    }];
    
    
    return controller;
}

- (void)setupNavigationButtons {
    __unsafe_unretained RXTaskListTableViewController *bself = self;
    
    self.leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hamburger"] style:UIBarButtonItemStyleBordered block:^{
        BOOL isHamburgerOpen = [[RXApplicationState sharedInstance] isHamburgerOpen];
        [[RXApplicationState sharedInstance] setIsHamburgerOpen:!isHamburgerOpen];
    }];
    
}

#pragma mark Setup MVC and bindings


- (void)setupBindings{
    __unsafe_unretained RXTaskListTableViewController *bself = self;
    
    
    [[RXApplicationState sharedInstance] bind:@"isHamburgerOpen" executeBlockImmediatly:YES withBlock:^(id value) {
        [bself.revealController setRearVisible:[value boolValue]];
    }];
    
    [[RXApplicationState sharedInstance] bind:@"selectedPatient" withBlock:^(id value) {
        [bself.navigationController pushViewController:[RXPatientSplitController controller] animated:YES];
    }];
}

- (void)revealController:(ZUUIRevealController *)revealController didHideRearViewController:(UIViewController *)rearViewController
{
    RXApplicationState *appState = [RXApplicationState sharedInstance];
    if (appState.isHamburgerOpen == YES) {
        appState.isHamburgerOpen = NO;
    }
}

- (void)revealController:(ZUUIRevealController *)revealController didRevealRearViewController:(UIViewController *)rearViewController
{
    RXApplicationState *appState = [RXApplicationState sharedInstance];
    if (appState.isHamburgerOpen == NO) {
        appState.isHamburgerOpen = YES;
    }
}

@end
