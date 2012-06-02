//
//  Location.h
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SGPBaseManagedObject.h"

@class Game, Tournament;

@interface Location : SGPBaseManagedObject

@property (nonatomic, retain) NSString * streetAddress;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSSet *games;
@property (nonatomic, retain) NSSet *tournaments;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addGamesObject:(Game *)value;
- (void)removeGamesObject:(Game *)value;
- (void)addGames:(NSSet *)values;
- (void)removeGames:(NSSet *)values;

- (void)addTournamentsObject:(Tournament *)value;
- (void)removeTournamentsObject:(Tournament *)value;
- (void)addTournaments:(NSSet *)values;
- (void)removeTournaments:(NSSet *)values;

@end
