//
//  Tournament.m
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "Tournament.h"
#import "EliminationStyle.h"

@implementation Tournament

@dynamic primID;
@dynamic displayName;
@dynamic status;
@dynamic tournamentType;
@dynamic eliminationStyle;
@dynamic sportType;
@dynamic games;
@dynamic participants;
@dynamic location;

+ (NSString*)entityName {
    return NSStringFromClass([Tournament class]);
}


@end
