//
//  SGPTeamListViewController.m
//  TMS
//
//  Created by Jeff Morris on 5/16/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPTeamListViewController.h"

@interface SGPTeamListViewController ()

@end

@implementation SGPTeamListViewController

@synthesize tableView;

#pragma mark - Private Methods

- (IBAction)nextView:(id)sender {
    // Do any validation here...
    [self cancelModalView:sender];
}

- (IBAction)editSegmentButtonTapped:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    switch ([seg selectedSegmentIndex]) {
        case 0: {
            // Add a new participant
        } break;
        case 1: {
            // Set Ranking
        } break;
        case 2: {
            // Add an existing participant
        } break;
    }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:NSLocalizedString(@"Participants", @"Participants")];
    
    // Check a clear footer at the bottom of the table, so we have a padding for the segment buttons
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    [footerView setBackgroundColor:[UIColor clearColor]];
    [[self tableView] setTableFooterView:footerView];
    
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"Done")
                                                                                  style:UIBarButtonItemStyleBordered
                                                                                 target:self
                                                                                 action:@selector(nextView:)]];
    
    [[self tableView] setEditing:YES animated:YES];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdent = @"";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    [[cell textLabel] setText:[NSString stringWithFormat:@"Participant %d",indexPath.row+1]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tv canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // User deleted a participant from the list.
}

- (void)tableView:(UITableView *)tv moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // User change the ranking order.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tv deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
