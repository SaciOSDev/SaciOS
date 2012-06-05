//
//  NSString+WhiteSpacing.m
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "NSString+WhiteSpacing.h"

@implementation NSString (WhiteSpacing)

- (NSString*)stringByTrimmingLeadingWhitespace {
    if ([self length]==0) return self;
    NSInteger i = 0;
    while ((i < [self length]) && [[NSCharacterSet whitespaceCharacterSet] characterIsMember:[self characterAtIndex:i]]) {
        i++;
    }
    return [self substringFromIndex:i];
}

- (NSString*)stringByTrimmingTailingWhitespace {
    if ([self length]==0) return self;
    NSInteger i = 0;
    while ((i < [self length]) && [[NSCharacterSet whitespaceCharacterSet] characterIsMember:[self characterAtIndex:[self length]-1-i]]) {
        i++;
    }
    return [self substringWithRange:NSMakeRange(0,[self length]-i)];
}

- (NSString*)stringByTrimmingLeadingAndTailingWhitespace {
    return [[self stringByTrimmingLeadingWhitespace] stringByTrimmingTailingWhitespace];
}

@end
