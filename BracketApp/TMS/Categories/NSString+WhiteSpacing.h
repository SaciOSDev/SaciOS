//
//  NSString+WhiteSpacing.h
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WhiteSpacing)

- (NSString*)stringByTrimmingLeadingWhitespace;
- (NSString*)stringByTrimmingTailingWhitespace;
- (NSString*)stringByTrimmingLeadingAndTailingWhitespace;

@end
