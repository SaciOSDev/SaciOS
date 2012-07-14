//
//  Tournament.h
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SGPBaseManagedObject.h"

@class EliminationStyle, Game, Location, Participant, SportType, TournamentType;

@interface Tournament : SGPBaseManagedObject

@property (nonatomic, retain) NSNumber * endDate;
@property (nonatomic, retain) NSNumber * startDate;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) EliminationStyle *eliminationStyle;
@property (nonatomic, retain) NSSet *games;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) NSOrderedSet *participants;
@property (nonatomic, retain) SportType *sportType;
@property (nonatomic, retain) TournamentType *tournamentType;

@end

@interface Tournament (CoreDataGeneratedAccessors)

- (void)addGamesObject:(Game *)value;
- (void)removeGamesObject:(Game *)value;
- (void)addGames:(NSSet *)values;
- (void)removeGames:(NSSet *)values;

- (void)insertObject:(Participant *)value inParticipantsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromParticipantsAtIndex:(NSUInteger)idx;
- (void)insertParticipants:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeParticipantsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInParticipantsAtIndex:(NSUInteger)idx withObject:(Participant *)value;
- (void)replaceParticipantsAtIndexes:(NSIndexSet *)indexes withParticipants:(NSArray *)values;
- (void)addParticipantsObject:(Participant *)value;
- (void)removeParticipantsObject:(Participant *)value;
- (void)addParticipants:(NSOrderedSet *)values;
- (void)removeParticipants:(NSOrderedSet *)values;

@end
