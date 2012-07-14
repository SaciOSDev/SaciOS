//
//  SGPTournamentDetailFrontViewController.m
//  TMS
//
//  Created by Jeff Morris on 4/30/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPTournamentDetailFrontViewController.h"
#import "SGPTournamentViewController.h"
#import "SGPTeamListViewController.h"
#import "Tournament.h"
#import "Participant.h"
#import "Location.h"
#import "SportType.h"
#import "EliminationStyle.h"
#import "TournamentType.h"
#import <QuartzCore/QuartzCore.h>

#define BORDER_RADIUS 21.0
#define BORDER_WIDTH 2.0
#define BORDER_COLOR [UIColor whiteColor]

@interface SGPTournamentDetailFrontViewController ()

@end

@implementation SGPTournamentDetailFrontViewController

@synthesize tournament;
@synthesize frontView;
@synthesize backView;
@synthesize sectionHeaderView;
@synthesize backTableView;
@synthesize parentNavController;
@synthesize bigButton;
@synthesize tournamentNameLbl;
@synthesize dateLbl;
@synthesize timeLbl;
@synthesize locationLbl;
@synthesize backgroundImage;
@synthesize sportImage;

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
    if ([self parentNavController]!=nil) 
    {
        SGPTournamentViewController *tvc = [[SGPTournamentViewController alloc] initWithNibName:@"SGPTournamentViewController" bundle:nil];
        [tvc setManagedObjectContext:[self managedObjectContext]];
        [tvc setTournament:[self tournament]];
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
    
    [self refreshData];
    
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

- (IBAction)editParticipants:(id)sender 
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    // Check to see if this tournament has started yet.
    if ([[[self tournament] tournamentType] isEqual:[TournamentType setupTournamentType:moc]]) {
        SGPTeamListViewController *vc = [[SGPTeamListViewController alloc] initWithNibName:@"SGPTeamListViewController" bundle:nil];
        [vc setManagedObjectContext:[self managedObjectContext]];
        [vc setTournament:[self tournament]];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        [nvc setModalPresentationStyle:UIModalPresentationFormSheet];
        [[self parentNavController] presentModalViewController:nvc animated:YES];  
    } 
    // If it has, do not allow them to edit the participants unless they reset.
    else if ([[[self tournament] tournamentType] isEqual:[TournamentType startedTournamentType:moc]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Tournament Started", @"Tournament Started")
                                                        message:NSLocalizedString(@"The tournament has already started and you can not edit the participant list unless you reset the tournament. Resetting the tournament will erase all games and scores, which can not be undone.", 
                                                                                  @"The tournament has already started and you can not edit the participant list unless you reset the tournament. Resetting the tournament will erase all games and scores, which can not be undone.") 
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                              otherButtonTitles:NSLocalizedString(@"Reset", @"Reset"),nil];
        [alert show];
    } 
    // If it has completed, it's too late.
    else if ([[[self tournament] tournamentType] isEqual:[TournamentType completedTournamentType:moc]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Tournament Completed", @"Tournament Completed")
                                                        message:NSLocalizedString(@"The tournament has already been completed and you can not edit the participant list.", 
                                                                                  @"The tournament has already been completed and you can not edit the participant list.") 
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK") 
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)refreshData {
    [[self tournamentNameLbl] setText:[[self tournament] displayName]];
    [[self dateLbl] setText:@"Dates Here"];
    [[self timeLbl] setText:@"Times Here"];
    [[self sportImage] setImage:[[[self tournament] sportType] image]];
    [[self locationLbl] setText:[[[self tournament] location] fullLocation]];
    [[self backTableView] reloadData];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[[self frontView] layer] setMasksToBounds:YES];
    [[[self frontView] layer] setCornerRadius:20];
    [[[self frontView] layer] setBorderWidth:2];
    [[[self frontView] layer] setBorderColor:[[UIColor blackColor] CGColor]];

    [[[self backView] layer] setMasksToBounds:YES];
    [[[self backView] layer] setCornerRadius:20];
    [[[self backView] layer] setBorderWidth:2];
    [[[self backView] layer] setBorderColor:[[UIColor blackColor] CGColor]];

    [self refreshData];
}

- (void)viewDidUnload
{
    [self setTournament:nil];
    [self setFrontView:nil];
    [self setBackView:nil];
    [self setBackTableView:nil];
    [self setParentNavController:nil];
    [self setBigButton:nil];
    [self setTournamentNameLbl:nil];
    [self setDateLbl:nil];
    [self setTimeLbl:nil];
    [self setLocationLbl:nil];
    [self setBackgroundImage:nil];
    [self setSportImage:nil];
    [super viewDidUnload];
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
    [[[cell imageView] layer] setMasksToBounds:YES];
    [[[cell imageView] layer] setCornerRadius:BORDER_RADIUS];
    [[[cell imageView] layer] setBorderWidth:BORDER_WIDTH];
    [[[cell imageView] layer] setBorderColor:[BORDER_COLOR CGColor]];
    [[cell imageView] setImage:photo];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self sectionHeaderView].frame.size.height;
}

- (UIView *)tableView:(UITableView *)tv viewForHeaderInSection:(NSInteger)section {
    return [self sectionHeaderView];
}

@end
