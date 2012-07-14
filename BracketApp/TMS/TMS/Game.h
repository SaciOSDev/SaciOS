//
//  Game.h
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SGPBaseManagedObject.h"

@class Tournament, Participant, Location;

@interface Game : SGPBaseManagedObject

@property (nonatomic, retain) NSNumber * endDate;
@property (nonatomic, retain) NSNumber * startDate;
@property (nonatomic, retain) NSNumber * gameNumber;
@property (nonatomic, retain) NSNumber * scoreForP1;
@property (nonatomic, retain) NSNumber * scoreForP2;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) Tournament *tournament;
@property (nonatomic, retain) NSOrderedSet *participants;
@property (nonatomic, retain) Participant *winner;
@property (nonatomic, retain) Location *location;
@end

@interface Game (CoreDataGeneratedAccessors)

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
