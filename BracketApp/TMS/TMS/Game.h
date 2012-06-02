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

@class Tournament;

@interface Game : SGPBaseManagedObject

@property (nonatomic, retain) NSNumber * primID;
@property (nonatomic, retain) NSNumber * gameNumber;
@property (nonatomic, retain) NSNumber * scoreForP1;
@property (nonatomic, retain) NSNumber * scoreForP2;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) Tournament *tournament;
@property (nonatomic, retain) NSOrderedSet *participants;
@property (nonatomic, retain) NSManagedObject *winner;
@property (nonatomic, retain) NSManagedObject *location;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inParticipantsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromParticipantsAtIndex:(NSUInteger)idx;
- (void)insertParticipants:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeParticipantsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInParticipantsAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceParticipantsAtIndexes:(NSIndexSet *)indexes withParticipants:(NSArray *)values;
- (void)addParticipantsObject:(NSManagedObject *)value;
- (void)removeParticipantsObject:(NSManagedObject *)value;
- (void)addParticipants:(NSOrderedSet *)values;
- (void)removeParticipants:(NSOrderedSet *)values;
@end
