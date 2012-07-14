//
//  SGPLocationListViewController.m
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 Pearson. All rights reserved.
//

#import "SGPLocationListViewController.h"
#import "SGPLocationDetailViewController.h"
#import "Location.h"

@interface SGPLocationListViewController ()

@end

@implementation SGPLocationListViewController

@synthesize tableView;
@synthesize tournament;

#pragma mark - Private Methods

- (void)addLocation:(id)sender
{
    SGPLocationDetailViewController *vc = [[SGPLocationDetailViewController alloc] initWithNibName:@"SGPLocationDetailViewController" bundle:nil];
    [vc setManagedObjectContext:[self managedObjectContext]];
    [[self navigationController] pushViewController:vc animated:YES];
}

- (void)editMode:(id)sender
{
    [super editMode:sender];
    [[self tableView] reloadData];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setManagedObjectClass:[Location class]];
    [self setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"displayName" 
                                                                                    ascending:YES]]];
    [self setTitle:NSLocalizedString(@"Locations", @"Locations")];
    
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                               target:self
                                                                                               action:@selector(addLocation:)]];
}

- (void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
    [[self tableView] reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section 
{
    return [[[self fetchedResultsController] fetchedObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSString *cellIdent = @"UITableViewCellStyleDefault";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    Location *location = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[location fullLocation]];
    if ([[[self tournament] location] isEqual:location]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];        
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete: { 
            Location *location = [[[self fetchedResultsController] fetchedObjects] objectAtIndex:indexPath.row];
            if ([[location tournaments] count]>0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Delete Problem", @"Delete Problem")
                                                                message:NSLocalizedString(@"We can not delete this location because it are associated to a tournament or game. Remove this location from all tournaments and games then try to delete it again.", 
                                                                                          @"We can not delete this location because it are associated to a tournament or game. Remove this location from all tournaments and games then try to delete it again.") 
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"OK", @"OK") 
                                                      otherButtonTitles:nil];
                [alert show];
            } else {
                [[self managedObjectContext] deleteObject:location];
                [Location saveAll:[self managedObjectContext]];                
                [tv reloadData];
            }
        } break;
        case UITableViewCellEditingStyleInsert: { 
            
        } break;
        case UITableViewCellEditingStyleNone: { 
            
        } break;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    [[self tournament] setLocation:[[self fetchedResultsController] objectAtIndexPath:indexPath]];
    [[self navigationController] popViewControllerAnimated:YES];
}

@end