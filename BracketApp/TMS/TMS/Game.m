//
//  Game.m
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "Game.h"
#import "Tournament.h"

@implementation Game

@dynamic primID;
@dynamic gameNumber;
@dynamic scoreForP1;
@dynamic scoreForP2;
@dynamic status;
@dynamic tournament;
@dynamic participants;
@dynamic winner;
@dynamic location;

+ (NSString*)entityName {
    return NSStringFromClass([Game class]);
}

@end
