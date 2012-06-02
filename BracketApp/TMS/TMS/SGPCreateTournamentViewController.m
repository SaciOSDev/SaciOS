//
//  SGPCreateTournamentViewController.m
//  TMS
//
//  Created by Jeff Morris on 5/16/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPCreateTournamentViewController.h"
#import "SGPSportTypeViewController.h"
#import "SGPTeamListViewController.h"

@interface SGPCreateTournamentViewController ()

@end

@implementation SGPCreateTournamentViewController

@synthesize tournNameTextField;

#pragma mark - Public Methods

- (IBAction)nextView:(id)sender {
    // First check to see if the user has entered a Tournament name...
    if ([tournNameTextField text]!=nil && [[tournNameTextField text] length]>0) {
        SGPTeamListViewController *vc = [[SGPTeamListViewController alloc] initWithNibName:@"SGPTeamListViewController" bundle:nil];
        [vc setManagedObjectContext:[self managedObjectContext]];
        [[self navigationController] pushViewController:vc animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Tournament Name", @"Tournament Name")
                                                        message:NSLocalizedString(@"Please enter a tournament name before you process.", 
                                                                                  @"Please enter a tournament name before you process.") 
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK") 
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)selectSportType:(id)sender {
    SGPSportTypeViewController *vc = [[SGPSportTypeViewController alloc] initWithNibName:@"SGPSportTypeViewController" bundle:nil];
    [vc setManagedObjectContext:[self managedObjectContext]];
    [[self navigationController] pushViewController:vc animated:YES];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:NSLocalizedString(@"Add Tournament", @"Add Tournament")];
    [[[self navigationController] navigationBar] setTintColor:[UIColor blackColor]];
    
    [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                              target:self
                                                                                              action:@selector(cancelModalView:)]];
    
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", @"Next")
                                                                                  style:UIBarButtonItemStyleBordered
                                                                                 target:self
                                                                                 action:@selector(nextView:)]];
}

- (void)viewDidUnload
{
    [self setTournNameTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
