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

- (NSString*)fullAddress {
    NSString *str = @"";
    if ([self streetAddress]!=nil && [[self streetAddress] length]>0) {
        str = [NSString stringWithFormat:@"%@%@",str, [self streetAddress]];
    }
    if ([self city]!=nil && [[self city] length]>0) {
        if ([str length]>0) str = [NSString stringWithFormat:@"%@, ",str];
        str = [NSString stringWithFormat:@"%@%@",str, [self city]];
    }
    if ([self state]!=nil && [[self state] length]>0) {
        if ([str length]>0) str = [NSString stringWithFormat:@"%@ ",str];
        str = [NSString stringWithFormat:@"%@%@",str, [self state]];
    }
    if ([self zip]!=nil && [[self zip] length]>0) {
        if ([str length]>0) str = [NSString stringWithFormat:@"%@ ",str];
        str = [NSString stringWithFormat:@"%@%@",str, [self zip]];
    }
    return str;
}

- (NSString*)fullLocation {
    NSString *str = @"";
    if ([self displayName]!=nil && [[self displayName] length]>0) {
        str = [NSString stringWithFormat:@"%@%@",str, [self displayName]];
    }
    NSString *fullAdd = [self fullAddress];
    if (fullAdd!=nil && [fullAdd length]>0) {
        if ([str length]>0) str = [NSString stringWithFormat:@"%@ - ",str];
        str = [NSString stringWithFormat:@"%@%@",str, fullAdd];
    }
    return str;
}

@end
