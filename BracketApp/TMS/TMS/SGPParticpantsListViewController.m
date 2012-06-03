//
//  SGPParticpantsListViewController.m
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPParticpantsListViewController.h"
#import "Participant.h"

@interface SGPParticpantsListViewController ()

@end

@implementation SGPParticpantsListViewController

@synthesize tournament;

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setManagedObjectClass:[Participant class]];
    [self setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"displayName" 
                                                                                    ascending:YES]]];
    [self setTitle:NSLocalizedString(@"Existing Participants", @"Existing Participants")];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSString *cellIdent = @"UITableViewCellStyleDefault";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
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

    if ([[[self tournament] participants] containsObject:participant]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];        
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Participant *participant = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    if ([[[self tournament] participants] containsObject:participant]) {
        [[self tournament] removeParticipantsObject:participant];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    } else {
        [[self tournament] addParticipantsObject:participant];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];        
    }
}

@end
