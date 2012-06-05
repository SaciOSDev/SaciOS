//
//  SGPCreateTournamentViewController.m
//  TMS
//
//  Created by Jeff Morris on 5/16/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPCreateTournamentViewController.h"
#import "SGPSportTypeViewController.h"
#import "SGPLocationListViewController.h"
#import "SGPTeamListViewController.h"
#import "Tournament.h"
#import "SportType.h"
#import "Location.h"
#import "TournamentType.h"
#import "NSString+WhiteSpacing.h"

@interface SGPCreateTournamentViewController ()

@end

@implementation SGPCreateTournamentViewController

@synthesize scrollView = _scrollView;
@synthesize tournNameTextField = _tournNameTextField;
@synthesize locationBtn = _locationBtn;
@synthesize sportTypeBtn = _sportTypeBtn;
@synthesize startDateBtn = _startDateBtn;
@synthesize endDateBtn = _endDateBtn;
@synthesize tournament = _tournament;

#pragma mark - Private Methods

- (void)updateViewFrKeyboard:(NSNotification*)aNotification up:(BOOL)up {
    // If we are on an iPad, don't update the view.
    if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPhone) return;
    
    NSDictionary* userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = [self scrollView].frame;
    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
    keyboardFrame.size.height -= self.navigationController.navigationBar.frame.size.height;
    newFrame.size.height -= keyboardFrame.size.height * (up?1:-1);
    [self scrollView].frame = newFrame;
    [self scrollView].contentInset = UIEdgeInsetsMake(0.0, 0.0, newFrame.size.width, (up?newFrame.size.height:0.0));    
    [self scrollView].scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, newFrame.size.width, (up?newFrame.size.height:0.0));
    
    [UIView commitAnimations];   
}

#pragma mark - Public Methods

- (void)cancelModalView:(id)sender
{
    if (![[[self vcSettings] objectForKey:EDIT_MODE] boolValue]) {
        [[self managedObjectContext] deleteObject:[self tournament]];
        [Tournament saveAll:[self managedObjectContext]];
        [self setTournament:nil];
    }
    [super cancelModalView:sender];        
}

- (IBAction)nextView:(id)sender {
    // First check to see if the user has entered a Tournament name...
    [[self tournNameTextField] setText:[[[self tournNameTextField] text] stringByTrimmingLeadingAndTailingWhitespace]];
    if ([[self tournNameTextField] text]!=nil && [[[self tournNameTextField] text] length]>0) {
        [[self tournament] setDisplayName:[[self tournNameTextField] text]];
        SGPTeamListViewController *vc = [[SGPTeamListViewController alloc] initWithNibName:@"SGPTeamListViewController" bundle:nil];
        [vc setManagedObjectContext:[self managedObjectContext]];
        [vc setTournament:[self tournament]];
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
    [vc setTournament:[self tournament]];
    [[self navigationController] pushViewController:vc animated:YES];
}

- (IBAction)selectLocation:(id)sender {
    SGPLocationListViewController *vc = [[SGPLocationListViewController alloc] initWithNibName:@"SGPLocationListViewController" bundle:nil];
    [vc setManagedObjectContext:[self managedObjectContext]];
    [vc setTournament:[self tournament]];
    [[self navigationController] pushViewController:vc animated:YES];
}

- (IBAction)selectStartDate:(id)sender{
    
}

- (IBAction)selectEndDate:(id)sender {

}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self tournament]==nil) {
        [self setTournament:[Tournament createObject:[self managedObjectContext]]];
        [[self tournament] setCreateDate:[NSDate date]];        
        [self setTitle:NSLocalizedString(@"New Tournament", @"New Tournament")];
        [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                  target:self
                                                                                                  action:@selector(cancelModalView:)]];
    } else {
        [[self vcSettings] setObject:[NSNumber numberWithBool:YES] forKey:EDIT_MODE];
        [self setTitle:[[self tournament] displayName]];
    }
    
    [[[self navigationController] navigationBar] setTintColor:[UIColor darkGrayColor]];
        
    if ([[[self tournament] tournamentType] isEqual:[TournamentType setupTournamentType:[self managedObjectContext]]]) {
        [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", @"Next")
                                                                                      style:UIBarButtonItemStyleBordered
                                                                                     target:self
                                                                                     action:@selector(nextView:)]];        
    } else {
        [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                  target:self
                                                                                                  action:@selector(cancelModalView:)]];
    }
}

- (void)viewDidUnload
{
    [self setTournNameTextField:nil];
    [self setTournament:nil];
    [self setScrollView:nil];
    [self setLocationBtn:nil];
    [self setSportTypeBtn:nil];
    [self setStartDateBtn:nil];
    [self setEndDateBtn:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[self tournNameTextField] setText:[[self tournament] displayName]];
    [[self tournNameTextField] becomeFirstResponder];
    [[self sportTypeBtn] setTitle:[NSString stringWithFormat:NSLocalizedString(@"Sport Type: %@", @"Sport Type: %@"),[[[self tournament] sportType] displayName]] forState:UIControlStateNormal];        
    NSString *location = [[[self tournament] location] fullLocation];
    if (location==nil || [location length]<=0) {
        location = NSLocalizedString(@"Location", @"Location");
    }
    [[self locationBtn] setTitle:location forState:UIControlStateNormal];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self tournament] setDisplayName:[[self tournNameTextField] text]];
    [[self tournNameTextField] resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end
