//
//  SGPTournamentDetailFrontViewController.m
//  TMS
//
//  Created by Jeff Morris on 4/30/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPTournamentDetailFrontViewController.h"

@interface SGPTournamentDetailFrontViewController ()

@end

@implementation SGPTournamentDetailFrontViewController

- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"SGPTournamentDetailFrontViewController" bundle:nil]) {
        pageNumber = page;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
