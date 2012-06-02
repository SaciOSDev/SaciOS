//
//  Location.m
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "Location.h"
#import "Game.h"
#import "Tournament.h"

@implementation Location

@dynamic streetAddress;
@dynamic zip;
@dynamic state;
@dynamic city;
@dynamic displayName;
@dynamic games;
@dynamic tournaments;

+ (NSString*)entityName {
    return NSStringFromClass([Location class]);
}

@end
