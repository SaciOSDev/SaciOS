//
//  TournamentType.m
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "TournamentType.h"
#import "Tournament.h"

@implementation TournamentType

@dynamic displayName;
@dynamic tournaments;

+ (NSString*)entityName {
    return NSStringFromClass([TournamentType class]);
}

@end
