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
@dynamic photo;
@dynamic tournaments;

+ (NSString*)entityName {
    return NSStringFromClass([SportType class]);
}

- (UIImage*)image {
    if ([self photo]) {
        return [UIImage imageNamed:[self photo]];
    }
    return nil;
}

+ (SportType*)otherSportType:(NSManagedObjectContext*)moc {
    return (SportType*)[SportType findObject:[self entityName] 
                               withPredicate:[NSPredicate predicateWithFormat:@"displayName == 'Other'"]
                                     withMOC:moc];
}

@end
