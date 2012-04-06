//
//  JSONtestAppDelegate.h
//  JSONtest
//
//  Created by Morris, Jeffrey on 4/13/11.
//  Copyright 2011 JDMDesign.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class JSONtestViewController;

@interface JSONtestAppDelegate : NSObject <UIApplicationDelegate> {
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet JSONtestViewController *viewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (NSManagedObjectContext*)managedObjectContext;
- (NSManagedObjectModel*)managedObjectModel;
- (NSPersistentStoreCoordinator*)persistentStoreCoordinator;

@end
