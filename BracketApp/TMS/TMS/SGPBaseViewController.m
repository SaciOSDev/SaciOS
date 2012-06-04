//
//  SGPBaseViewController.m
//  TMS
//
//  Created by Jeff Morris on 4/30/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"

@interface SGPBaseViewController ()

@end

@implementation SGPBaseViewController

@synthesize managedObjectClass = _managedObjectClass;
@synthesize sortDescriptors = _sortDescriptors;
@synthesize predicate = _predicate;
@synthesize vcSettings = _vcSettings;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark - Public Methods

- (void)cancelModalView:(id)sender
{
    [[self navigationController] dismissModalViewControllerAnimated:YES];
}

- (void)editMode:(id)sender
{
    if (![[self vcSettings] objectForKey:EDIT_MODE]) {
        [[self vcSettings] setObject:[NSNumber numberWithBool:NO] forKey:EDIT_MODE];
    }
    BOOL editMode = ![[[self vcSettings] objectForKey:EDIT_MODE] boolValue];
//    [[self vcSettings] removeObjectForKey:EDIT_MODE];
    [[self vcSettings] setObject:[NSNumber numberWithBool:editMode] forKey:EDIT_MODE];
    if (editMode) {
        [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                  target:self
                                                                                                  action:@selector(editMode:)]];
    } else {
        [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                                  target:self
                                                                                                  action:@selector(editMode:)]];
    }
}

#pragma mark - NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setVcSettings:[NSMutableDictionary dictionary]];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidUnload
{
    [self setManagedObjectContext:nil];
    [self setFetchedResultsController:nil];
    [self setSortDescriptors:nil];
    [self setPredicate:nil];
    [self setVcSettings:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self.managedObjectClass entityName] 
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    [fetchRequest setPredicate:self.predicate];
    [fetchRequest setSortDescriptors:self.sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
                                                                                                managedObjectContext:self.managedObjectContext 
                                                                                                  sectionNameKeyPath:nil 
                                                                                                           cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // Should be over written in extending class
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    // Should be over written in extending class
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    // Should be over written in extending class
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // Should be over written in extending class
}

@end
