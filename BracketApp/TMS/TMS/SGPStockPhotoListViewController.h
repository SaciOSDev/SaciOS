//
//  SGPStockPhotoListViewController.h
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"

@class Participant;

@interface SGPStockPhotoListViewController : SGPBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Participant *particpant;

@end
