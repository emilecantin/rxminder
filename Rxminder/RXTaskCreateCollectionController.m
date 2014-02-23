//
//  RXTaskCreateCollectionController.m
//  Rxminder
//
//  Created by Francois Courville on 2/22/2014.
//  Copyright (c) 2014 HackingHealth. All rights reserved.
//

#import "RXTaskCreateCollectionController.h"
#import "RXApplicationState.h"
#import "RXTaskDescriptor.h"
#import "RXTimeDescriptorController.h"

@interface RXTaskCreateCollectionController ()

@property(nonatomic, strong) CKArrayCollection *taskDescriptor;

@property(nonatomic, strong) CKCollectionViewLayout *layout;
@property(nonatomic, strong) CKCollection *collection;
@property(nonatomic, strong) CKCollectionCellControllerFactory *factory;

@end

@implementation RXTaskCreateCollectionController

#pragma mark ViewController Life Cycle

+ (RXTaskCreateCollectionController *)controllerWithCollection:(CKCollection *)collection {
    RXTaskCreateCollectionController *controller = [RXTaskCreateCollectionController controller];
    controller.collection = collection;
    
    return controller;
}

- (void)postInit{
    [super postInit];
    [self setupCollectionViewLayout];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setupCollectionView];
    
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

#pragma mark Initializing Collection View Controller

- (void)setupCollectionViewLayout{
    
    //TODO : Setup your layout
    
    CKCollectionViewGridLayout* layout  = [[CKCollectionViewGridLayout alloc]init];
    layout.pages = @[
                             @[
                                 @[  @(0.5),@(0.5) ],
                                 @[  @(0.5),@(0.5) ],
                                 @[  @(0.5),@(0.5) ],
                                 @[  @(0.5),@(0.5) ]
                                 ]
                             ];
    layout.horizontalSpace = 10;
    layout.verticalSpace = 10;
    layout.orientation = CKCollectionViewLayoutOrientationVertical;
    layout.pagingEnabled = YES;
    
    self.layout = layout;
    
    __unsafe_unretained RXTaskCreateCollectionController* bself = self;
    
    CKCollectionCellControllerFactory* factory = [CKCollectionCellControllerFactory factory];
    [factory addItemForObjectOfClass:[RXTaskDescriptor class] withControllerCreationBlock:^CKCollectionCellController *(id object, NSIndexPath *indexPath) {
        CKCollectionCellContentViewController* content = [bself contentViewControllerForObject:object];
        CKCollectionContentCellController* cell = [[CKCollectionContentCellController alloc]initWithContentViewController:content];
        
        CKCallback *layout = [CKCallback callbackWithBlock:^id(id value){
            [bself layoutCellController:cell withObject:object atIndexPath:indexPath];
            return nil;
        }];
        
        [cell setSetupCallback:layout];
        
        CKCallback* selection = [CKCallback callbackWithBlock:^id(id value) {
            [bself didSelectObject:object atIndexPath:indexPath];
            return nil;
        }];
        
        [cell setSelectionCallback:selection];
        return cell;
    }];
    
    self.factory = factory;
}

- (void)setupCollectionView {
    [self setupWithLayout:self.layout collection:self.collection factory:self.factory];
}

- (void)layoutCellController:(CKCollectionContentCellController *)controller withObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    RXTaskDescriptor *descriptor = (RXTaskDescriptor *)object;
    __unsafe_unretained CKCollectionViewCell *cellView = (CKCollectionViewCell *)controller.view;
    
    [controller beginBindingsContextByRemovingPreviousBindings];
    
    [descriptor bind:@"name" executeBlockImmediatly:YES withBlock:^(id value) {
        UILabel *label = [cellView.contentView viewWithKeyPath:@"descriptorName"];
        label.text = value;
    }];
    
    [descriptor bind:@"type" executeBlockImmediatly:YES withBlock:^(id value) {
        CKImageView *imageView = [cellView.contentView viewWithKeyPath:@"buttonImage"];
        imageView.defaultImage = [UIImage imageNamed:value];
    }];
    
    [controller endBindingsContext];

}

- (CKCollectionCellContentViewController*)contentViewControllerForObject:(id)object{
    
    //TODO : Setup the content view controller representing the specified object
    CKCollectionCellContentViewController *cell = [[CKCollectionCellContentViewController alloc] init];
    
    return cell;
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath{
    RXTaskDescriptor *descriptor = (RXTaskDescriptor *)object;
    CKViewController *nextViewController;
    
    if (descriptor.subtasks == nil
        || descriptor.subtasks.count == 0) {
        nextViewController = [RXTimeDescriptorController controller];
    } else {
        CKCollection *collection = [CKArrayCollection collectionWithObjectsFromArray:descriptor.subtasks];
        nextViewController = [RXTaskCreateCollectionController controllerWithCollection:collection];
    }
    
    [[RXApplicationState sharedInstance] addTaskDescriptorToBuild:object];
    [self.navigationController pushViewController:nextViewController animated:YES];
}

#pragma mark Setup MVC and bindings

- (void)setupBindings{
    //TODO : Setup Views and bindings
}

@end
