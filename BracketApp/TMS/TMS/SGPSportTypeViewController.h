//
//  SGPSportTypeViewController.h
//  TMS
//
//  Created by Jeff Morris on 5/16/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"
#import "Tournament.h"

@interface SGPSportTypeViewController : SGPBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Tournament *tournament;

@end
