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
    if ([self streetAddress]) {
        str = [NSString stringWithFormat:@"%@%@",str, [self streetAddress]];
    }
    if ([self city]) {
        if ([str length]>0) str = [NSString stringWithFormat:@"%@, ",str];
        str = [NSString stringWithFormat:@"%@%@",str, [self city]];
    }
    if ([self state]) {
        if ([str length]>0) str = [NSString stringWithFormat:@"%@ ",str];
        str = [NSString stringWithFormat:@"%@%@",str, [self state]];
    }
    if ([self zip]) {
        if ([str length]>0) str = [NSString stringWithFormat:@"%@ ",str];
        str = [NSString stringWithFormat:@"%@%@",str, [self zip]];
    }
    return str;
}

- (NSString*)fullLocation {
    NSString *str = @"";
    if ([self displayName]) {
        str = [NSString stringWithFormat:@"%@%@",str, [self displayName]];
    }
    NSString *fullAdd = [self fullAddress];
    if (fullAdd!=nil) {
        if ([str length]>0) str = [NSString stringWithFormat:@"%@ - ",str];
        str = [NSString stringWithFormat:@"%@%@",str, [self streetAddress]];
    }
    return str;
}

@end
