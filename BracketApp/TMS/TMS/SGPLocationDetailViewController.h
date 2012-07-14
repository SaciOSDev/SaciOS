//
//  SGPLocationDetailViewController.h
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 Pearson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPBaseViewController.h"

@interface SGPLocationDetailViewController : SGPBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *displayNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *streetAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipTextField;

@end
