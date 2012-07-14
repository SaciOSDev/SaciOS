//
//  SGPAppDelegate.m
//  TMS
//
//  Created by Jeff Morris on 4/30/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPAppDelegate.h"
#import "SGPTournamentSelectorViewController.h"

#import "SportType.h"
#import "TournamentType.h"
#import "EliminationStyle.h"
#import "Participant.h"
#import "StockPhoto.h"

#define DATABASE_DATA_CREATED @"DATABASE_DATA_CREATED"

@implementation SGPAppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize navigationController = _navigationController;
@synthesize tournamentSelectorViewController = _tournamentSelectorViewController;

#pragma mark - Private Methods

- (void)createDatabaseData {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:DATABASE_DATA_CREATED]) {
        if ([self managedObjectContext]!=nil) {
            // Create the Sport Types
            NSMutableArray *displayNames = [NSMutableArray arrayWithObjects:
                                            [NSArray arrayWithObjects:@"Baseball",@"sport-baseball.png", nil],
                                            [NSArray arrayWithObjects:@"Softball",@"sport-baseball.png", nil],
                                            [NSArray arrayWithObjects:@"Football",@"sport-football.png", nil],
                                            [NSArray arrayWithObjects:@"Basketball",@"sport-basketball.png", nil],
                                            [NSArray arrayWithObjects:@"Soccer",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Tennis",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Lion",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Archery",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Volleyball",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Dodgeball",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Kickball",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Wrestling",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Swimming",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Track",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Golf",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Bocce",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Bowling",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Curling",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Cycling",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Martial Arts",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Fencing",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Boxing",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Billards",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Darts",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Beer Pong",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Dance",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Fishing",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Rubgy",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Racing",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Cricket",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Gymnastics",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Handball",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Water Polo",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Rowing",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Skiing",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Lacrosse",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Polo",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Card Games",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Shooting",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Table Tennis",@"Check.png", nil],
                                            [NSArray arrayWithObjects:@"Other",@"Check.png", nil],
                                            nil];
            for (NSArray *data in displayNames) {
                SportType *sportType = [SportType createObject:[self managedObjectContext]];
                [sportType setDisplayName:[data objectAtIndex:0]];
                [sportType setPhoto:[data objectAtIndex:1]];
            }
            
            // Create the Tournament Types
            [displayNames removeAllObjects];
            [displayNames addObjectsFromArray:[NSArray arrayWithObjects:
                                               @"Setup",
                                               @"Started",
                                               @"Completed",
                                               nil]];
            for (NSString *displayName in displayNames) {
                NSManagedObject *mo = [NSEntityDescription insertNewObjectForEntityForName:[TournamentType entityName] 
                                                                    inManagedObjectContext:[self managedObjectContext]];
                [mo setValue:displayName forKey:@"displayName"];
            }
            
            // Create the EliminationStyles
            [displayNames removeAllObjects];
            [displayNames addObjectsFromArray:[NSArray arrayWithObjects:
                                               @"Single",
                                               nil]];
            for (NSString *displayName in displayNames) {
                NSManagedObject *mo = [NSEntityDescription insertNewObjectForEntityForName:[EliminationStyle entityName] 
                                                                    inManagedObjectContext:[self managedObjectContext]];
                [mo setValue:displayName forKey:@"displayName"];
            }
            
            // Create the StockPhotos
            [displayNames removeAllObjects];
            [displayNames addObjectsFromArray:[NSArray arrayWithObjects:
                                               [NSArray arrayWithObjects:@"Lion",@"Reseed.png", nil],
                                               [NSArray arrayWithObjects:@"Tiger",@"Check.png", nil],
                                               [NSArray arrayWithObjects:@"Panther",@"Search.png", nil],
                                               [NSArray arrayWithObjects:@"Jaguar",@"Promote.png", nil],
                                               [NSArray arrayWithObjects:@"Mt. Lion",@"AddRemove.png", nil],
                                               nil]];
            for (NSArray *data in displayNames) {
                NSManagedObject *mo = [NSEntityDescription insertNewObjectForEntityForName:[StockPhoto entityName] 
                                                                    inManagedObjectContext:[self managedObjectContext]];
                [mo setValue:[data objectAtIndex:0] forKey:@"displayName"];
                [mo setValue:[data objectAtIndex:1] forKey:@"photo"];
            }
            
            // Create some dumby participants... We'll remove this on later down the road...
            [displayNames removeAllObjects];
            [displayNames addObjectsFromArray:[NSArray arrayWithObjects:
                                               @"Yuri Costa",
                                               @"Jeff Morris",
                                               @"Matt Hutchins",
                                               @"Steve Bowling",
                                               @"Steve Zakar",
                                               @"Adam Ruggles",
                                               @"Gary Fox",
                                               @"Ivan Villa",
                                               @"Brian Galloway",
                                               @"Bill Hooper",
                                               @"Andy Mileusnic",
                                               @"Daniel Mileusnic",
                                               nil]];
            for (NSString *displayName in displayNames) {
                NSManagedObject *mo = [NSEntityDescription insertNewObjectForEntityForName:[Participant entityName] 
                                                                    inManagedObjectContext:[self managedObjectContext]];
                [mo setValue:displayName forKey:@"displayName"];
            }
            
            // Save the data and continue on
            [self saveContext];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:DATABASE_DATA_CREATED];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

#pragma mark - Public Methods

- (void)saveContext
{
    [SGPBaseManagedObject saveAll:[self managedObjectContext]];
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self createDatabaseData];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    SGPTournamentSelectorViewController *tsvc = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        tsvc = [[SGPTournamentSelectorViewController alloc] initWithNibName:@"SGPTournamentSelectorViewController" bundle:nil];
    } else {
        tsvc = [[SGPTournamentSelectorViewController alloc] initWithNibName:@"SGPTournamentSelectorViewController" bundle:nil];
    }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:tsvc];
    self.window.rootViewController = self.navigationController;
    [tsvc setManagedObjectContext:[self managedObjectContext]];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TMS" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TMS.sqlite"];    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
