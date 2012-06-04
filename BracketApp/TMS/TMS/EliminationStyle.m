//
//  EliminationStyle.m
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "EliminationStyle.h"

@implementation EliminationStyle

@dynamic displayName;
@dynamic tournaments;

+ (NSString*)entityName {
    return NSStringFromClass([EliminationStyle class]);
}

+ (EliminationStyle*)singleEliminationStyle:(NSManagedObjectContext*)moc {
    return (EliminationStyle*)[EliminationStyle findObject:[self entityName] 
                                             withPredicate:[NSPredicate predicateWithFormat:@"displayName == 'Single'"]
                                                   withMOC:moc];
}

@end
