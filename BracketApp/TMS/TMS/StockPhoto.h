//
//  StockPhoto.h
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 Pearson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SGPBaseManagedObject.h"

@class Participant;

@interface StockPhoto : SGPBaseManagedObject

@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSSet *particpants;

- (UIImage*)image;

@end

@interface StockPhoto (CoreDataGeneratedAccessors)

- (void)addParticipantsObject:(Participant *)value;
- (void)removeParticipantsObject:(Participant *)value;
- (void)addParticipants:(NSSet *)values;
- (void)removeParticipants:(NSSet *)values;

@end
