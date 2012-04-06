//
//  JSONtestViewController.m
//  JSONtest
//
//  Created by Morris, Jeffrey on 4/13/11.
//  Copyright 2011 JDMDesign.com. All rights reserved.
//

#import "JSONtestViewController.h"
#import "JSONKit.h"
#import <CoreData/CoreData.h>
#import "JSONtestAppDelegate.h"
#import "DBRecord.h"
#import "NewEntryViewController.h"

#define DEMO_TABLE_NAME     @"wsdemo"
#define DEMO_URL            @"http://www.peargle.com/json/"

@implementation JSONtestViewController

@synthesize tableView;
@synthesize frc = _frc;

- (BOOL)createReceivedDataObject {
    if (receivedData==nil) {
        receivedData = [[NSMutableData alloc] init];
        return true;
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sync In Progress", @"Sync In Progress") 
                                                        message:NSLocalizedString(@"Another sync is already in progress, please wait for the other sync to complete.",
                                                                                  @"Another sync is already in progress, please wait for the other sync to complete.") 
                                                       delegate:nil 
                                              cancelButtonTitle:nil 
                                              otherButtonTitles:NSLocalizedString(@"OK", @"OK"), nil];
        
        [alert show];
        [alert release];
        return false;
    }
}

- (void)dealloc
{
    [tableView release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WS Demo";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                           target:self
                                                                                           action:@selector(refreshFromServer:)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                            target:self
                                                                                            action:@selector(createNewEntry:)] autorelease];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

- (IBAction)refreshFromServer:(id)sender {
    if ([self createReceivedDataObject]) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?q=%@",DEMO_URL,DEMO_TABLE_NAME]];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection release];
        [request release];
    }
}

- (IBAction)createNewEntry:(id)sender {
    NewEntryViewController *newVC = [[NewEntryViewController alloc] initWithNibName:@"NewEntryViewController" bundle:nil];
    newVC.jsonViewController = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:newVC];
    [self.navigationController presentModalViewController:nav animated:YES];
    [nav release];
    [newVC release];
}

- (IBAction)createNewRecordWithData:(NSDictionary*)data {
    if (data && [self createReceivedDataObject]) {
        NSString *jsonString = [data JSONString];
        if (jsonString) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?q=%@&a=s",DEMO_URL,DEMO_TABLE_NAME]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:[jsonString dataUsingEncoding: NSUTF8StringEncoding]];
            NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [connection release];
            [request release];  
        }
    }
}

- (DBRecord*)findDBRecordByID:(int)pid withMOC:(NSManagedObjectContext*)moc {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"DBRecord" inManagedObjectContext:moc];
    [fetchRequest setEntity:entityDesc];
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"serverId == %d",pid]]];	
	
	NSError *error;
    NSArray *items = [moc executeFetchRequest:fetchRequest error:&error];
	[fetchRequest release];
	if (items!=nil && [items count]>0) {
		return [items objectAtIndex:0];
	}
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *jsonString = [[NSString alloc] initWithData:receivedData 
                                                 encoding:NSUTF8StringEncoding];    
    NSError *error = nil;
    NSMutableArray *response = 
    [jsonString objectFromJSONStringWithParseOptions:JKParseOptionUnicodeNewlines 
                                               error:&error]; 
    if (error) {
        NSLog(@"Error: JSON Parsing - %@",[error domain]);
    }
    
    // Build an array from the dictionary for easy access to each entry
    if (response) {
        
        NSArray *results = nil;
        // Check
        if ([response isKindOfClass:[NSDictionary class]]) {
            results = [(NSDictionary*)response objectForKey:@"results"];
        }
    
        if (results && [results isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in results) {           
                JSONtestAppDelegate *appDel = (JSONtestAppDelegate*)[[UIApplication sharedApplication] delegate];
                
                NSManagedObjectContext *moc = [appDel managedObjectContext];
                
                DBRecord *pe = [self findDBRecordByID:[[item objectForKey:@"id"] intValue] withMOC:moc];
                if (pe==nil) {
                    pe = [NSEntityDescription insertNewObjectForEntityForName:@"DBRecord" 
                                                       inManagedObjectContext:moc];
                }
                
                pe.serverId = [NSNumber numberWithInt:[[item objectForKey:@"id"] intValue]];
                pe.title = [item objectForKey:@"title"];
                pe.descript = [item objectForKey:@"descript"];
                
                NSError *error = nil;
                if (![moc save:&error]) {
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                } 
            }
        } else if (results && [response isKindOfClass:[NSDictionary class]]) {
            // We have a single object so do something with it...
            // TODO - We should check to see if this we a success = true and then reload
            
            // Memory Management and Clean-up
            [receivedData release];
            receivedData = nil;
            
            [self refreshFromServer:self];
            
            return;
        }
    }
    
    // Memory Management and Clean-up
    [receivedData release];
    receivedData = nil;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (data!=nil) [receivedData appendData:data];
}

//////////////////////////////////////////////////////////////////////////////////
// UITableViewDelegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    
    NewEntryViewController *newVC = [[NewEntryViewController alloc] initWithNibName:@"NewEntryViewController" bundle:nil];
    newVC.jsonViewController = self;
    newVC.dBRecord = (DBRecord*)[self.frc objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:newVC animated:YES];
    [newVC release];
}

//////////////////////////////////////////////////////////////////////////////////
// UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    DBRecord *dBRecord = (DBRecord*)[self.frc objectAtIndexPath:indexPath];
    cell.textLabel.text = [dBRecord.serverId stringValue];
    cell.detailTextLabel.text = dBRecord.descript;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.frc==nil) return 1; 
    return [[self.frc sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.frc==nil) return 0; 
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.frc sections] objectAtIndex:section];
    if (sectionInfo==nil) return 0;
    return [sectionInfo numberOfObjects];  
}

- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.frc sections] objectAtIndex:section];
    return [sectionInfo name];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"default";
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                      reuseIdentifier:cellId];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
     
    return cell;
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([self createReceivedDataObject]) {
            DBRecord *dBRecord = (DBRecord*)[self.frc objectAtIndexPath:indexPath];

            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?q=%@&a=d&id=%d",DEMO_URL,DEMO_TABLE_NAME,[[dBRecord serverId] intValue]]];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [connection release];
            [request release];
            
            // Delete the managed object for the given index path
            NSManagedObjectContext *context = [self.frc managedObjectContext];
            [context deleteObject:[self.frc objectAtIndexPath:indexPath]];
            
            // Save the context.
            NSError *error = nil;
            if (![context save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
    } 
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSFetchedResultsController

- (NSFetchedResultsController *)frc {
    if (_frc != nil) {
        return _frc;
    }
    
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Get the NSManagedObjectContext
    JSONtestAppDelegate *appDel = (JSONtestAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [appDel managedObjectContext];
    
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DBRecord" 
                                              inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Create a sort descriptor
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:
                                      [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES],
                                      [NSSortDescriptor sortDescriptorWithKey:@"serverId" ascending:YES],
                                      [NSSortDescriptor sortDescriptorWithKey:@"descript" ascending:YES],
                                      nil]];	

    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *afrc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
																		   managedObjectContext:moc 
																			 sectionNameKeyPath:@"groupTitle" 
                                                                                      cacheName:nil];
    afrc.delegate = self;
    self.frc = afrc;
    
    [afrc release];
    [fetchRequest release];
    
    NSError *error = nil;
    if (![_frc performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _frc;
}    

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tv = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tv insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tv cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tv insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
	[self.tableView reloadData];
}

@end
