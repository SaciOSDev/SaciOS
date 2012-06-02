//
//  SGPCreateTournamentViewController.h
//  TMS
//
//  Created by Jeff Morris on 5/16/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"

@interface SGPCreateTournamentViewController : SGPBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *tournNameTextField;

- (IBAction)nextView:(id)sender;
- (IBAction)selectSportType:(id)sender;

@end
