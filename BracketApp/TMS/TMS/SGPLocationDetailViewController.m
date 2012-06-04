//
//  SGPLocationDetailViewController.m
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 Pearson. All rights reserved.
//

#import "SGPLocationDetailViewController.h"
#import "Location.h"
#import "NSString+WhiteSpacing.h"

@interface SGPLocationDetailViewController ()
@property (strong, nonatomic) Location *location;
@end

@implementation SGPLocationDetailViewController

@synthesize displayNameTextField = _tournNameTextField;
@synthesize streetAddressTextField = _sportTypeTextField;
@synthesize cityTextField = _locationTextField;
@synthesize stateTextField = _stateTextField;
@synthesize zipTextField = _zipTextField;
@synthesize location = _location;

#pragma mark - Private Methods

- (void)cancelModalView:(id)sender
{
    if (![[[self vcSettings] objectForKey:EDIT_MODE] boolValue]) {
        [[self managedObjectContext] deleteObject:[self location]];
        [Location saveAll:[self managedObjectContext]];
        [self setLocation:nil];
    }
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)saveLocation:(id)sender
{
    // Validate the name...
    [[self displayNameTextField] setText:[[[self displayNameTextField] text] stringByTrimmingLeadingAndTailingWhitespace]];
    [[self streetAddressTextField] setText:[[[self streetAddressTextField] text] stringByTrimmingLeadingAndTailingWhitespace]];
    [[self cityTextField] setText:[[[self cityTextField] text] stringByTrimmingLeadingAndTailingWhitespace]];
    [[self stateTextField] setText:[[[self stateTextField] text] stringByTrimmingLeadingAndTailingWhitespace]];
    [[self zipTextField] setText:[[[self zipTextField] text] stringByTrimmingLeadingAndTailingWhitespace]];
    
    // TODO - We should probablye validate that we are not entering a duplicate location...

    [[self displayNameTextField] resignFirstResponder];
    [[self streetAddressTextField] resignFirstResponder];
    [[self cityTextField] resignFirstResponder];
    [[self stateTextField] resignFirstResponder];
    [[self zipTextField] resignFirstResponder];

    [[self location] setDisplayName:[[self displayNameTextField] text]];
    [[self location] setStreetAddress:[[self streetAddressTextField] text]];
    [[self location] setCity:[[self cityTextField] text]];
    [[self location] setState:[[self stateTextField] text]];
    [[self location] setZip:[[self zipTextField] text]];
    
    [Location saveAll:[self managedObjectContext]];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLocation:[Location createObject:[self managedObjectContext]]];    
    [self setTitle:NSLocalizedString(@"New Location", @"New Location")];
    [[[self navigationController] navigationBar] setTintColor:[UIColor darkGrayColor]];
    [[self displayNameTextField] becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setDisplayNameTextField:nil];
    [self setStreetAddressTextField:nil];
    [self setCityTextField:nil];
    [self setStateTextField:nil];
    [self setZipTextField:nil];
    [self setLocation:nil];
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
    [[self displayNameTextField] setText:[[self location] displayName]];
    [[self streetAddressTextField] setText:[[self location] streetAddress]];
    [[self cityTextField] setText:[[self location] city]];
    [[self stateTextField] setText:[[self location] state]];
    [[self zipTextField] setText:[[self location] zip]];
}

- (void)viewWillAppear:(BOOL)animated  
{
    [super viewWillAppear:animated];
    if (![[[self vcSettings] objectForKey:EDIT_MODE] boolValue]) {
        [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                  target:self
                                                                                                  action:@selector(cancelModalView:)]];        
        
        [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                                   target:self
                                                                                                   action:@selector(saveLocation:)]];
    } else {
        [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                                  target:self
                                                                                                  action:@selector(saveLocation:)]];        
    }
}

@end