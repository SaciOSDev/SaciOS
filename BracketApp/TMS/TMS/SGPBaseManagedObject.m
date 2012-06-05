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

+ (NSMutableArray*)findObjects:(NSString *)entity withPredicate:(NSPredicate*)predicate withSort:(NSArray*)sortDescriptors withMOC:(NSManagedObjectContext*)moc {
    if (moc==nil) return nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entity inManagedObjectContext:moc];
    [fetchRequest setEntity:entityDesc];
	if (sortDescriptors!=nil) {
		[fetchRequest setSortDescriptors:sortDescriptors];	
	}
	
	if (predicate!=nil) {
		[fetchRequest setPredicate:predicate];	
	}
	
	NSError *error;
    NSArray *items = [moc executeFetchRequest:fetchRequest error:&error];
	NSMutableArray *mutableArray = nil;
	if (items!=nil && [items count]>0) {
		mutableArray = [NSMutableArray arrayWithArray:items];
	}
	
	return mutableArray;
}

+ (NSMutableArray*)findObjects:(NSString *)entity withPredicate:(NSPredicate*)predicate withMOC:(NSManagedObjectContext*)moc {
    return [SGPBaseManagedObject findObjects:entity withPredicate:predicate withSort:nil withMOC:moc];
}

+ (NSManagedObject*)findObject:(NSString *)entity withPredicate:(NSPredicate*)predicate withMOC:(NSManagedObjectContext*)moc {
    NSMutableArray *items = [self findObjects:entity withPredicate:predicate withMOC:moc];
	if (items==nil || [items count]<=0) return nil;
	return [items objectAtIndex:0];
}

+ (NSMutableArray*)findObjects:(NSString *)entity withPredicate:(NSPredicate*)predicate withSort:(NSArray*)sortDescriptors {
    return [SGPBaseManagedObject findObjects:entity withPredicate:predicate withSort:sortDescriptors withMOC:nil];
}

+ (NSMutableArray*)findObjects:(NSString *)entity withPredicate:(NSPredicate*)predicate {
    return [SGPBaseManagedObject findObjects:entity withPredicate:predicate withSort:nil withMOC:nil];
}

+ (NSManagedObject*)findObject:(NSString *)entity withPredicate:(NSPredicate*)predicate {
	return [SGPBaseManagedObject findObject:entity withPredicate:predicate withMOC:nil];
}

@end
