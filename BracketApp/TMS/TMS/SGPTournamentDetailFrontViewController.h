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
}

- (id)initWithPageNumber:(int)page;

@end
