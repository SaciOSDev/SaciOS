//
//  SGPLocationListViewController.h
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 Pearson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPBaseViewController.h"
#import "Tournament.h"

@interface SGPLocationListViewController : SGPBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) Tournament *tournament;

@end
