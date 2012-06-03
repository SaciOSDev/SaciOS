//
//  SGPBaseManagedObject.m
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPBaseManagedObject.h"

@implementation SGPBaseManagedObject

+ (NSString*)entityName
{
    // This should be overwritten in the extending class.
    return NSStringFromClass([SGPBaseManagedObject class]);
}

+ (id)createObject:(NSManagedObjectContext*)moc
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] 
                                         inManagedObjectContext:moc];
}

+ (void)saveAll:(NSManagedObjectContext*)moc
{
    NSError *error = nil;
    if (moc != nil) {
        if ([moc hasChanges] && ![moc save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        } 
    }
}

@end
