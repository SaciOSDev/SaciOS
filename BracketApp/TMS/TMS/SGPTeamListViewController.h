//
//  SGPTeamListViewController.h
//  TMS
//
//  Created by Jeff Morris on 5/16/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"

@interface SGPTeamListViewController : SGPBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)nextView:(id)sender;
- (IBAction)editSegmentButtonTapped:(id)sender;

@end
