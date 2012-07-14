//
//  SGPParticipantDetailViewController.h
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"
#import "Participant.h"

@interface SGPCreateParticipantViewController : SGPBaseViewController <UIActionSheetDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) Participant *participant;
@property (weak, nonatomic) IBOutlet UITextField *participantNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (strong, nonatomic) UIActionSheet *sheet;
@property (strong, nonatomic) UIPopoverController *popOverview;

- (IBAction)changeImage:(id)sender;

@end
