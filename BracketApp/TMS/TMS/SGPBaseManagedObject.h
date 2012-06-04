//
//  SGPBaseManagedObject.h
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface SGPBaseManagedObject : NSManagedObject

+ (NSString*)entityName;
+ (id)createObject:(NSManagedObjectContext*)moc;
+ (void)saveAll:(NSManagedObjectContext*)moc;
+ (NSMutableArray*)findObjects:(NSString *)entity withPredicate:(NSPredicate*)predicate withSort:(NSArray*)sortDescriptors withMOC:(NSManagedObjectContext*)moc;
+ (NSMutableArray*)findObjects:(NSString *)entity withPredicate:(NSPredicate*)predicate withMOC:(NSManagedObjectContext*)moc;
+ (NSManagedObject*)findObject:(NSString *)entity withPredicate:(NSPredicate*)predicate withMOC:(NSManagedObjectContext*)moc;
+ (NSMutableArray*)findObjects:(NSString *)entity withPredicate:(NSPredicate*)predicate withSort:(NSArray*)sortDescriptors;
+ (NSMutableArray*)findObjects:(NSString *)entity withPredicate:(NSPredicate*)predicate;
+ (NSManagedObject*)findObject:(NSString *)entity withPredicate:(NSPredicate*)predicate;

@end
