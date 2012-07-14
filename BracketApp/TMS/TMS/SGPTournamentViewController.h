//
//  SGPTournamentViewController.h
//  TMS
//
//  Created by Jeff Morris on 5/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"
#import "AwesomeMenu.h"
#import "Tournament.h"

@interface SGPTournamentViewController : SGPBaseViewController <AwesomeMenuDelegate>

@property (strong, nonatomic) Tournament * tournament;
@property (strong, nonatomic) AwesomeMenu * menu;

@end
