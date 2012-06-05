//
//  SGPParticipantDetailViewController.m
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPCreateParticipantViewController.h"
#import "Participant.h"
#import "UIImage+Resize.h"
#import "SGPStockPhotoListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+WhiteSpacing.h"

#define BORDER_RADIUS 20.0
#define BORDER_WIDTH 1.0

@interface SGPCreateParticipantViewController ()

@end

@implementation SGPCreateParticipantViewController

@synthesize participant;
@synthesize participantNameTextField;
@synthesize photoImage;
@synthesize sheet;
@synthesize popOverview;

#pragma mark - Private Method

- (void)killPopover {
    if (self.popOverview) {
        if ([self.popOverview isPopoverVisible]) {
            [self.popOverview dismissPopoverAnimated:YES];
        }
    }
    self.popOverview = nil;
}

- (void)killSheet 
{
    if (self.sheet) {
        if ([self.sheet isVisible]) {
            [self.sheet dismissWithClickedButtonIndex:999 animated:NO];            
        }
    }
    self.sheet = nil;
}

- (void)saveParticipant:(id)sender
{
    // Validate the name...
    [[self participantNameTextField] setText:[[[self participantNameTextField] text] stringByTrimmingLeadingAndTailingWhitespace]];
    if ([[self participantNameTextField] text]==nil || [[[self participantNameTextField] text] length]<=0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Participant's Name", @"Participant's Name")
                                                        message:NSLocalizedString(@"Please enter a participant name before you process.", 
                                                                                  @"Please enter a participant name before you process.") 
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK") 
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // TODO - Validate that we are not entering someone with the same name...
    
    [[self participant] setDisplayName:[[self participantNameTextField] text]];
    [Participant saveAll:[self managedObjectContext]];
    [[self participantNameTextField] resignFirstResponder];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Public Method

- (void)cancelModalView:(id)sender
{
    if (![[[self vcSettings] objectForKey:EDIT_MODE] boolValue]) {
        [[self managedObjectContext] deleteObject:participant];
        [self setParticipant:nil];
    }
    [[self participantNameTextField] resignFirstResponder];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)changeImage:(id)sender
{
    [self killSheet];
    [self setSheet:[[UIActionSheet alloc] initWithTitle:nil
                                               delegate:self
                                      cancelButtonTitle:nil
                                 destructiveButtonTitle:nil 
                                      otherButtonTitles:nil]];
        
    // Now create all the buttons for the ActionSheet
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [[self sheet] addButtonWithTitle:NSLocalizedString(@"Take Photo", @"Take Photo")];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [[self sheet] addButtonWithTitle:NSLocalizedString(@"Choose Photo", @"Choose Photo")];
    }
    [[self sheet] addButtonWithTitle:NSLocalizedString(@"Use A Stock Photo", @"Use A Stock Photo")];
    [self sheet].cancelButtonIndex = [[self sheet] addButtonWithTitle:NSLocalizedString(@"Cancel", @"Cancel")];
    
    if ([[self sheet] numberOfButtons]>1) {
        if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPad) {
            [[self sheet] showInView:[self view]];
        } else {
            [[self sheet] showFromRect:[sender frame] inView:[self view] animated:YES];
        }
    }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"New Participant", @"New Participant")];
    
    [[[self photoImage] layer] setMasksToBounds:YES];
    [[[self photoImage] layer] setCornerRadius:BORDER_RADIUS];
    [[[self photoImage] layer] setBorderWidth:BORDER_WIDTH];
    [[[self photoImage] layer] setBorderColor:[[UIColor blackColor] CGColor]];

    [[self photoImage] setImage:[[self photoImage] image]]; 
    [[self participantNameTextField] becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setParticipantNameTextField:nil];
    [self setPhotoImage:nil];
    [super viewDidUnload];
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
                                                                                                   action:@selector(saveParticipant:)]];
    } else {
        [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                                   target:self
                                                                                                   action:@selector(saveParticipant:)]];        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self participant] setDisplayName:[[self participantNameTextField] text]];
}

- (void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
    UIImage *image = [[self participant] image];
    if (!image) {
        image = [UIImage imageNamed:@"Photo.png"];
    }
    [[self photoImage] setImage:image];
    [[self participantNameTextField] setText:[[self participant] displayName]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        [self killPopover];
    }
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *btnTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:NSLocalizedString(@"Take Photo", @"Take Photo")]) {
        UIImagePickerController *impc = [[UIImagePickerController alloc] init];
        impc.delegate = self;
        impc.allowsEditing = YES;
        impc.sourceType = UIImagePickerControllerSourceTypeCamera;
        if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPad) {
            [self.navigationController presentModalViewController:impc animated:YES];    
        } else {
            [self killPopover];
            self.popOverview = [[UIPopoverController alloc] initWithContentViewController:impc];
            self.popOverview.delegate = self;
            [self.popOverview presentPopoverFromRect:CGRectMake(0, 0, self.view.frame.size.width, 0) 
                                              inView:[self view]
                            permittedArrowDirections:UIPopoverArrowDirectionAny 
                                            animated:YES];
        }
    } else if ([btnTitle isEqualToString:NSLocalizedString(@"Choose Photo", @"Choose Photo")]) {
        UIImagePickerController *impc = [[UIImagePickerController alloc] init];
        impc.delegate = self;
        impc.allowsEditing = YES;
        impc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPad) {
            [self.navigationController presentModalViewController:impc animated:YES];    
        } else {
            [self killPopover];
            self.popOverview = [[UIPopoverController alloc] initWithContentViewController:impc];
            self.popOverview.delegate = self;
            [self.popOverview presentPopoverFromRect:CGRectMake(0, 0, self.view.frame.size.width, 0) 
                                              inView:[self view]
                            permittedArrowDirections:UIPopoverArrowDirectionAny 
                                            animated:YES];
        }
    } else if ([btnTitle isEqualToString:NSLocalizedString(@"Use A Stock Photo", @"Use A Stock Photo")]) {
        SGPStockPhotoListViewController *impc = [[SGPStockPhotoListViewController alloc] initWithNibName:@"SGPStockPhotoListViewController" bundle:nil];
        [impc setManagedObjectContext:[self managedObjectContext]];
        [impc setParticpant:[self participant]];
        [self.navigationController pushViewController:impc animated:YES];    
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (info!=nil) {
        UIImage *newImage = [info valueForKey:UIImagePickerControllerEditedImage];
        if (!newImage) {
            newImage = [info valueForKey:UIImagePickerControllerOriginalImage];
        }
        if (newImage) {
            newImage = [newImage resizedImage:CGSizeMake(640, 640) interpolationQuality:kCGInterpolationDefault];
            [[self participant] saveImage:newImage];
            [[self photoImage] setImage:newImage];
        }
    }
    if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPad) {
        [self.navigationController dismissModalViewControllerAnimated:YES]; 
    } else {
        [self killPopover];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPad) {
        [self.navigationController dismissModalViewControllerAnimated:YES]; 
    } else {
        [self killPopover];
    }
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.popOverview = nil;
}

@end
