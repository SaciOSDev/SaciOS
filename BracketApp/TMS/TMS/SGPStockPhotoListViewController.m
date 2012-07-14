//
//  SGPStockPhotoListViewController.m
//  TMS
//
//  Created by Jeff Morris on 6/3/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPStockPhotoListViewController.h"
#import "StockPhoto.h"
#import "Participant.h"

@interface SGPStockPhotoListViewController ()

@end

@implementation SGPStockPhotoListViewController

@synthesize particpant;

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setManagedObjectClass:[StockPhoto class]];
    [self setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"displayName" 
                                                                                    ascending:YES]]];
    [self setTitle:NSLocalizedString(@"Stock Photos", @"Stock Photos")];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSString *cellIdent = @"UITableViewCellStyleDefault";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    StockPhoto *stockPhoto = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[stockPhoto displayName]];
    [[cell imageView] setImage:[stockPhoto image]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[self particpant] setStockPhoto:[[self fetchedResultsController] objectAtIndexPath:indexPath]];
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
