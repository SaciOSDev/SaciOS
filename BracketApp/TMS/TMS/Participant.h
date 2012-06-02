//
//  Participant.h
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SGPBaseManagedObject.h"

@class Game, Tournament;

@interface Participant : SGPBaseManagedObject

@property (nonatomic, retain) NSNumber * primID;
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSSet *tournaments;
@property (nonatomic, retain) Game *games;
@property (nonatomic, retain) NSSet *gamesWon;
@end

@interface Participant (CoreDataGeneratedAccessors)

- (void)addTournamentsObject:(Tournament *)value;
- (void)removeTournamentsObject:(Tournament *)value;
- (void)addTournaments:(NSSet *)values;
- (void)removeTournaments:(NSSet *)values;

- (void)addGamesWonObject:(Game *)value;
- (void)removeGamesWonObject:(Game *)value;
- (void)addGamesWon:(NSSet *)values;
- (void)removeGamesWon:(NSSet *)values;

@end
