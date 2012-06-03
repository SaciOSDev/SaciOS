//
//  SGPTournamentViewController.m
//  TMS
//
//  Created by Jeff Morris on 5/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPTournamentViewController.h"

@interface SGPTournamentViewController ()

@end

@implementation SGPTournamentViewController

@synthesize tournament;

#pragma mark - Public Methods

- (IBAction)navigateBackHome:(id)sender 
{
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setTournament:nil];
    [super viewDidUnload];
}

@end
