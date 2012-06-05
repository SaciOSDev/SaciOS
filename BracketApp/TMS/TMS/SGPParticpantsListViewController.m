//
//  SGPParticpantsListViewController.m
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPParticpantsListViewController.h"
#import "SGPCreateParticipantViewController.h"
#import "Participant.h"

@interface SGPParticpantsListViewController ()

@end

@implementation SGPParticpantsListViewController

@synthesize tournament;
@synthesize tableView;

#pragma mark - Public Methods

- (void)editMode:(id)sender 
{
    [super editMode:sender];
    [[self tableView] reloadData];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setManagedObjectClass:[Participant class]];
    [self setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"displayName" 
                                                                                    ascending:YES]]];
    [self setTitle:NSLocalizedString(@"Existing Participants", @"Existing Participants")];
    
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                               target:self
                                                                                               action:@selector(editMode:)]];

}

- (void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
    [[self tableView] reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv
{
    return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section 
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSString *cellIdent = @"UITableViewCellStyleDefault";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    Participant *participant = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[participant displayName]];
    UIImage *photo = [participant image];
    if (!photo) {
        photo = [UIImage imageNamed:@"Silhouette.png"];
    }
    [[cell imageView] setImage:photo];

    if ([[[self vcSettings] objectForKey:EDIT_MODE] boolValue]) {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    } else if ([[[self tournament] participants] containsObject:participant]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];        
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete: { 
            Participant *participant = [[[self fetchedResultsController] fetchedObjects] objectAtIndex:indexPath.row];
            if ([[participant tournaments] count]>0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Delete Problem", @"Delete Problem")
                                                                message:NSLocalizedString(@"We can not delete this participant because they are associated to a tournament. Remove this participant from all tournaments then try to delete them again.", 
                                                                                          @"We can not delete this participant because they are associated to a tournament. Remove this participant from all tournaments then try to delete them again.") 
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"OK", @"OK") 
                                                      otherButtonTitles:nil];
                [alert show];
            } else {
                [[self managedObjectContext] deleteObject:participant];
                [Participant saveAll:[self managedObjectContext]];                
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
    UITableViewCell *cell = [tv cellForRowAtIndexPath:indexPath];
    Participant *participant = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    if ([[[self vcSettings] objectForKey:EDIT_MODE] boolValue]) {
        SGPCreateParticipantViewController *vc = [[SGPCreateParticipantViewController alloc] initWithNibName:@"SGPCreateParticipantViewController" bundle:nil];
        [vc setManagedObjectContext:[self managedObjectContext]];
        [vc setParticipant:participant];
        [[vc vcSettings] setObject:[NSNumber numberWithBool:YES] forKey:EDIT_MODE];
        [[self navigationController] pushViewController:vc animated:YES];
    } else if ([[[self tournament] participants] containsObject:participant]) {
        [[self tournament] removeParticipantsObject:participant];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    } else {
        [[self tournament] addParticipantsObject:participant];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];        
    }
}

@end
