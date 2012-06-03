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

@end
