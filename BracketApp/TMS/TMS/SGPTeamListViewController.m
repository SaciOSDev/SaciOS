//
//  SGPTeamListViewController.m
//  TMS
//
//  Created by Jeff Morris on 5/16/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPTeamListViewController.h"
#import "Participant.h"
#import "SGPParticpantsListViewController.h"
#import "SGPCreateParticipantViewController.h"

@interface SGPTeamListViewController ()
@property BOOL editingMode;
@end

@implementation SGPTeamListViewController

@synthesize tableView;
@synthesize tournament;
@synthesize editingMode;

#pragma mark - Private Methods

- (IBAction)nextView:(id)sender {
    [[self tournament] setDisplayName:[[self tournament] displayName]]; // A trick to update the tournament and fire off some listeners
    [Participant saveAll:[self managedObjectContext]];
    [self cancelModalView:sender];
}

- (IBAction)editSegmentButtonTapped:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    switch ([seg selectedSegmentIndex]) {
        case 0: {
            // Add a new participant
            SGPCreateParticipantViewController *vc = [[SGPCreateParticipantViewController alloc] initWithNibName:@"SGPCreateParticipantViewController" bundle:nil];
            [vc setManagedObjectContext:[self managedObjectContext]];
            Participant *participant = [Participant createObject:[self managedObjectContext]];
            [[self tournament] addParticipantsObject:participant];
            [vc setParticipant:participant];
            [[self navigationController] pushViewController:vc animated:YES];
        } break;
        case 1: {
            // Add an existing participant
            SGPParticpantsListViewController *vc = [[SGPParticpantsListViewController alloc] initWithNibName:@"SGPParticpantsListViewController" bundle:nil];
            [vc setManagedObjectContext:[self managedObjectContext]];
            [vc setTournament:[self tournament]];
            [[self navigationController] pushViewController:vc animated:YES];
        } break;
        case 2: {
            UISegmentedControl *seg = (UISegmentedControl*)sender;
            [self setEditingMode:![self editingMode]];
            if ([self editingMode]) {
                [seg setTitle:NSLocalizedString(@"Done", @"Done") forSegmentAtIndex:2];
            } else {
                [seg setTitle:NSLocalizedString(@"Delete", @"Delete") forSegmentAtIndex:2];
            }
            [[self tableView] reloadData];
        } break;
    }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Participants", @"Participants")];
    [[[self navigationController] navigationBar] setTintColor:[UIColor darkGrayColor]];
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"Done")
                                                                                  style:UIBarButtonItemStyleBordered
                                                                                 target:self
                                                                                 action:@selector(nextView:)]];
    [self setEditingMode:NO];
    [[self tableView] setEditing:YES animated:YES];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setTournament:nil];
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[self tableView] reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [[[self tournament] participants] count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdent = @"";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    Participant *participant = [[[self tournament] participants] objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[NSString stringWithFormat:@"(%d) %@",indexPath.row+1,[participant displayName]]];
    UIImage *photo = [participant image];
    if (!photo) {
        photo = [UIImage imageNamed:@"Silhouette.png"];
    }
    [[cell imageView] setImage:photo];
    if ([self editingMode]) {
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    } else {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ([self editingMode]) ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tv canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // User deleted a participant from the list.
    Participant *participant = [[[self tournament] participants] objectAtIndex:indexPath.row];
    [[self tournament] removeParticipantsObject:participant];
    [tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
              withRowAnimation:UITableViewRowAnimationAutomatic];
    [tv performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
}

- (void)tableView:(UITableView *)tv moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // User change the ranking order.
    Participant *participant = [[[self tournament] participants] objectAtIndex:sourceIndexPath.row];
    [[self tournament] removeParticipantsObject:participant];
    [[self tournament] insertObject:participant inParticipantsAtIndex:destinationIndexPath.row];
    [tv performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    if ([self editingMode]) {
        Participant *participant = [[[self tournament] participants] objectAtIndex:indexPath.row];
        SGPCreateParticipantViewController *vc = [[SGPCreateParticipantViewController alloc] initWithNibName:@"SGPCreateParticipantViewController" bundle:nil];
        [vc setManagedObjectContext:[self managedObjectContext]];
        [vc setParticipant:participant];
        [[vc vcSettings] setObject:[NSNumber numberWithBool:YES] forKey:EDIT_MODE];
        [[self navigationController] pushViewController:vc animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
