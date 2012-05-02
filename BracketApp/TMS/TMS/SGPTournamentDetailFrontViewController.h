//
//  SGPTournamentDetailFrontViewController.h
//  TMS
//
//  Created by Jeff Morris on 4/30/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"

@interface SGPTournamentDetailFrontViewController : SGPBaseViewController {
    int pageNumber;
    BOOL flipped;
}

@property (strong, nonatomic) IBOutlet UIView *frontView;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) UINavigationController *parentNavController;

- (id)initWithPageNumber:(int)page;
- (IBAction)showTournament:(id)sender;
- (IBAction)flipView:(id)sender;
- (IBAction)showFronView;

@end
