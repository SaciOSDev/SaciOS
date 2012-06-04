//
//  SGPParticpantsListViewController.h
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"
#import "Tournament.h"

@interface SGPParticpantsListViewController : SGPBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Tournament *tournament;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
