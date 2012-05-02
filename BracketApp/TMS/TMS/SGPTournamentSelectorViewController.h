//
//  SGPTournamentSelectorViewController.h
//  TMS
//
//  Created by Jeff Morris on 4/30/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseViewController.h"

@interface SGPTournamentSelectorViewController : SGPBaseViewController <UIScrollViewDelegate> {
    BOOL pageControlBeingUsed;
    int rotatePageStart;
    NSMutableArray *viewControllers;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage:(id)sender;

- (IBAction)addTournament:(id)sender;
- (IBAction)deleteTournament:(id)sender;
- (IBAction)exportTournament:(id)sender;

@end
