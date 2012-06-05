//
//  SGPSportTypeViewController.m
//  TMS
//
//  Created by Jeff Morris on 5/16/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPSportTypeViewController.h"
#import "SportType.h"

@interface SGPSportTypeViewController ()

@end

@implementation SGPSportTypeViewController

@synthesize tournament;

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setManagedObjectClass:[SportType class]];
    [self setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"displayName" 
                                                                                    ascending:YES]]];
    [self setTitle:NSLocalizedString(@"Sport Types", @"Sport Types")];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section 
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSString *cellIdent = @"UITableViewCellStyleDefault";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    SportType *sportType = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[sportType displayName]];
    [[cell imageView] setImage:[sportType image]];
    if ([[[self tournament] sportType] isEqual:sportType]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];        
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    [[self tournament] setSportType:[[self fetchedResultsController] objectAtIndexPath:indexPath]];
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
