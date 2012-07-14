//
//  SGPTournamentDetailFrontViewController.h
//  TMS
//
//  Created by Jeff Morris on 4/30/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"
#import "Tournament.h"

@interface SGPTournamentDetailFrontViewController : SGPBaseViewController {
    int pageNumber;
    BOOL flipped;
}

@property (strong, nonatomic) Tournament *tournament;
@property (strong, nonatomic) IBOutlet UIView *frontView;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIView *sectionHeaderView;
@property (strong, nonatomic) IBOutlet UITableView *backTableView;
@property (strong, nonatomic) UINavigationController *parentNavController;
@property (strong, nonatomic) IBOutlet UIButton *bigButton;
@property (strong, nonatomic) IBOutlet UILabel *tournamentNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UILabel *timeLbl;
@property (strong, nonatomic) IBOutlet UILabel *locationLbl;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet UIImageView *sportImage;

- (id)initWithPageNumber:(int)page;

- (IBAction)showTournament:(id)sender;
- (IBAction)flipView:(id)sender;
- (IBAction)showFronView;
- (IBAction)editParticipants:(id)sender;
- (void)refreshData;

@end
