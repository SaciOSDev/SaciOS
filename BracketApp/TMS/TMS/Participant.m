//
//  Participant.m
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "Participant.h"
#import "Game.h"
#import "Tournament.h"

@implementation Participant

@dynamic primID;
@dynamic displayName;
@dynamic rank;
@dynamic photo;
@dynamic tournaments;
@dynamic games;
@dynamic gamesWon;

+ (NSString*)entityName {
    return NSStringFromClass([Participant class]);
}

@end
