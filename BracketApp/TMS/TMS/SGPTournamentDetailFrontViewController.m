//
//  SGPTournamentDetailFrontViewController.m
//  TMS
//
//  Created by Jeff Morris on 4/30/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPTournamentDetailFrontViewController.h"
#import "SGPTournamentViewController.h"

@interface SGPTournamentDetailFrontViewController ()

@end

@implementation SGPTournamentDetailFrontViewController

@synthesize frontView;
@synthesize backView;
@synthesize parentNavController;

#pragma mark - Public Methods

- (id)initWithPageNumber:(int)page
{
    if (self = [super initWithNibName:@"SGPTournamentDetailFrontViewController" bundle:nil]) {
        pageNumber = page;
    }
    return self;
}

- (IBAction)showTournament:(id)sender
{
    NSLog(@"TODO - Implement showTournament method!");
    if ([self parentNavController]!=nil) 
    {
        SGPTournamentViewController *tvc = [[SGPTournamentViewController alloc] initWithNibName:@"SGPTournamentViewController" bundle:nil];
        [tvc setManagedObjectContext:[self managedObjectContext]];
        [[self parentNavController] pushViewController:tvc animated:YES];
        [self showFronView];
        
    }
}

- (IBAction)flipView:(id)sender
{
    UIView *currentView = nil;
    UIView *toView = nil;
    if ([[self frontView] superview]!=nil) {
        currentView = [self frontView];
        toView = [self backView];
    } else {
        currentView = [self backView];
        toView = [self frontView];
    }
    
    toView.frame = currentView.frame;
    
    [UIView transitionWithView:self.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ 
                        [currentView setHidden:YES]; 
                        [self.view addSubview:toView];
                        [toView setHidden:NO];
                        [currentView removeFromSuperview];
                    } completion:nil]; 
    
}

- (IBAction)showFronView
{
    // If the back view is showing, call the flip view method
    if ([[self backView] superview]) {
        [self flipView:nil];
    }
}

#pragma mark - UIViewController

- (void)viewDidUnload
{
    [self setFrontView:nil];
    [self setBackView:nil];
    [self setParentNavController:nil];
    [super viewDidUnload];
}

@end
