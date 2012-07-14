//
//  SGPCreateTournamentViewController.h
//  TMS
//
//  Created by Jeff Morris on 5/16/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"
#import "Tournament.h"

@interface SGPCreateTournamentViewController : SGPBaseViewController

@property (strong, nonatomic) Tournament *tournament;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *tournNameTextField;
@property (strong, nonatomic) IBOutlet UIButton *locationBtn;
@property (strong, nonatomic) IBOutlet UIButton *sportTypeBtn;
@property (strong, nonatomic) IBOutlet UIButton *startDateBtn;
@property (strong, nonatomic) IBOutlet UIButton *endDateBtn;

- (IBAction)nextView:(id)sender;
- (IBAction)selectSportType:(id)sender;
- (IBAction)selectLocation:(id)sender;
- (IBAction)selectStartDate:(id)sender;
- (IBAction)selectEndDate:(id)sender;

@end
