//
//  DBRecord.m
//  JSONtest
//
//  Created by Morris, Jeffrey on 4/27/11.
//  Copyright 2011 JDMDesign.com. All rights reserved.
//

#import "DBRecord.h"

@implementation DBRecord

@dynamic serverId;
@dynamic title;
@dynamic descript;

- (NSString*)groupTitle {
    NSString *result = @"";
    if (self.title!=nil) {
        result = [self.title uppercaseString];
    }
    return result;
}

@end
