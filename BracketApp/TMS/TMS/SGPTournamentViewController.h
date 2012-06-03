//
//  SGPTournamentViewController.h
//  TMS
//
//  Created by Jeff Morris on 5/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"
#import "Tournament.h"

@interface SGPTournamentViewController : SGPBaseViewController

@property (strong, nonatomic) Tournament * tournament;

- (IBAction)navigateBackHome:(id)sender;

@end
