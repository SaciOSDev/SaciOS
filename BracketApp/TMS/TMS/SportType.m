//
//  SportType.m
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SportType.h"
#import "Tournament.h"

@implementation SportType

@dynamic displayName;
@dynamic tournaments;

+ (NSString*)entityName {
    return NSStringFromClass([SportType class]);
}

@end
