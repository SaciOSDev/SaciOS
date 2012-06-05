//
//  DBRecord.h
//  JSONtest
//
//  Created by Morris, Jeffrey on 4/27/11.
//  Copyright 2011 JDMDesign.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DBRecord : NSManagedObject {
@private
}

@property (nonatomic, retain) NSNumber * serverId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * descript;

- (NSString*)groupTitle;

@end
