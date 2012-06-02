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

@interface EliminationStyle : SGPBaseManagedObject

@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSSet *tournaments;
@end

@interface EliminationStyle (CoreDataGeneratedAccessors)

- (void)addTournamentsObject:(NSManagedObject *)value;
- (void)removeTournamentsObject:(NSManagedObject *)value;
- (void)addTournaments:(NSSet *)values;
- (void)removeTournaments:(NSSet *)values;

@end
