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
    [super viewDidAppear:YES];
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
