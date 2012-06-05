//
//  EliminationStyle.h
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SGPBaseManagedObject.h"

@class Tournament;

@interface EliminationStyle : SGPBaseManagedObject

@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSSet *tournaments;

+ (EliminationStyle*)singleEliminationStyle:(NSManagedObjectContext*)moc;

@end

@interface EliminationStyle (CoreDataGeneratedAccessors)

- (void)addTournamentsObject:(Tournament *)value;
- (void)removeTournamentsObject:(Tournament *)value;
- (void)addTournaments:(NSSet *)values;
- (void)removeTournaments:(NSSet *)values;

@end
