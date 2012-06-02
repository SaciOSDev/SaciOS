//
//  Tournament.h
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SGPBaseManagedObject.h"

@class EliminationStyle;

@interface Tournament : SGPBaseManagedObject

@property (nonatomic, retain) NSNumber * primID;
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSManagedObject *tournamentType;
@property (nonatomic, retain) EliminationStyle *eliminationStyle;
@property (nonatomic, retain) NSManagedObject *sportType;
@property (nonatomic, retain) NSSet *games;
@property (nonatomic, retain) NSSet *participants;
@property (nonatomic, retain) NSManagedObject *location;
@end

@interface Tournament (CoreDataGeneratedAccessors)

- (void)addGamesObject:(NSManagedObject *)value;
- (void)removeGamesObject:(NSManagedObject *)value;
- (void)addGames:(NSSet *)values;
- (void)removeGames:(NSSet *)values;

- (void)addParticipantsObject:(NSManagedObject *)value;
- (void)removeParticipantsObject:(NSManagedObject *)value;
- (void)addParticipants:(NSSet *)values;
- (void)removeParticipants:(NSSet *)values;

@end
