//
//  StockPhoto.m
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 Pearson. All rights reserved.
//

#import "StockPhoto.h"


@implementation StockPhoto

@dynamic displayName;
@dynamic photo;
@dynamic particpants;

+ (NSString*)entityName {
    return NSStringFromClass([StockPhoto class]);
}

- (UIImage*)image {
    if ([self photo]) {
        return [UIImage imageNamed:[self photo]];
    }
    return nil;
}

@end
