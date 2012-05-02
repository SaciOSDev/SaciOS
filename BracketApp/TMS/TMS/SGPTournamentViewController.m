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

#pragma mark - Public Methods

- (IBAction)navigateBackHome:(id)sender 
{
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
