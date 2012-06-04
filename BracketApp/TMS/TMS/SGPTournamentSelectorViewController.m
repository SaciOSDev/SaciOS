//
//  SGPTournamentSelectorViewController.m
//  TMS
//
//  Created by Jeff Morris on 4/30/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPTournamentSelectorViewController.h"
#import "SGPTournamentDetailFrontViewController.h"
#import "SGPCreateTournamentViewController.h"
#import "Tournament.h"

#define H_TOURNMENT_SQUARE() (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone ? 260 : 500)
#define V_TOURNMENT_SQUARE() (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone ? (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]) ? 260 : 160) : 500)
#define H_PADDING(width) ((width-H_TOURNMENT_SQUARE())/2)
#define V_PADDING(height) ((height-V_TOURNMENT_SQUARE())/2)

@interface SGPTournamentSelectorViewController ()

@end

@implementation SGPTournamentSelectorViewController

@synthesize scrollView;
@synthesize pageControl;

#pragma mark - Private Methods

- (CGRect)makeFrameForPage:(int)page {
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page + H_PADDING(frame.size.width);
    frame.origin.y = V_PADDING(frame.size.height);
    frame.size.width = H_TOURNMENT_SQUARE();
    frame.size.height = V_TOURNMENT_SQUARE();
    return frame;
}

- (void)resizeScrollView {
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self numberOfPages], self.scrollView.frame.size.height);
    
    // Now reset the coordinates of each bulletin in the list of viewControllers
    int pageCount = 0 ;
    for (UIViewController *vc in viewControllers) {
        if ((NSNull *)vc != [NSNull null])
        {
            vc.view.frame = [self makeFrameForPage:pageCount];
        }
        pageCount++;
    }
    
    // Now, update the scroll view to the appropriate page
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:NO];
}

- (void)deletePage:(int)page {
    SGPTournamentDetailFrontViewController *tdfvc = [self tdfViewControllerForPage:page];
    if (tdfvc!=[NSNull class]) {
        [[tdfvc view] removeFromSuperview];
    }
    [viewControllers removeObject:tdfvc];
    [[self pageControl] setNumberOfPages:[self numberOfPages]];
    if ([[self pageControl] currentPage]>=[[self pageControl] numberOfPages]) {
        [[self pageControl] setCurrentPage:[self numberOfPages]-1];
    }
    [[self pageControl] setNeedsDisplay];
    [self resizeScrollView];
}

- (SGPTournamentDetailFrontViewController*)tdfViewControllerForPage:(int)page {
    // Replace the placeholder if necessary
    SGPTournamentDetailFrontViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[SGPTournamentDetailFrontViewController alloc] initWithPageNumber:page];
        [controller setParentNavController:[self navigationController]];
        [controller setManagedObjectContext:[self managedObjectContext]];
        Tournament *tournament = [[[self fetchedResultsController] fetchedObjects] objectAtIndex:page];
        [controller setTournament:tournament];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    return controller;
}

- (int)numberOfPages {
    return [[[self fetchedResultsController] fetchedObjects] count];
}

- (void)loadScrollViewWithPage:(int)page {
    
    if (page < 0) return;
    if (page >= [self numberOfPages]) return;
    
    // Replace the placeholder if necessary
    SGPTournamentDetailFrontViewController *controller = [self tdfViewControllerForPage:page];    
    // Add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        controller.view.frame = [self makeFrameForPage:page];
        [self.scrollView addSubview:controller.view];
    }
//    [controller showFronView];
}

#pragma mark - Public Methods

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // update the scroll view to the appropriate page
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlBeingUsed = YES;
}

- (IBAction)addTournament:(id)sender
{
    SGPCreateTournamentViewController *vc = [[SGPCreateTournamentViewController alloc] initWithNibName:@"SGPCreateTournamentViewController" bundle:nil];
    [vc setManagedObjectContext:[self managedObjectContext]];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [nvc setModalPresentationStyle:UIModalPresentationFormSheet];
    [[self navigationController] presentModalViewController:nvc animated:YES];
}

- (IBAction)deleteTournament:(id)sender
{
    // First, find the tournament and delete it...
    Tournament *tournament = [[[self fetchedResultsController] fetchedObjects] objectAtIndex:pageControl.currentPage];
    if (tournament) {
        [[self managedObjectContext] deleteObject:tournament];
    }
    [Tournament saveAll:[self managedObjectContext]];
    // Note: The fetchresultscontroller will clean up the UI
}

- (IBAction)exportTournament:(id)sender
{

}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setManagedObjectClass:[Tournament class]];
    [self setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"createDate" 
                                                                                    ascending:YES]]];

    pageControlBeingUsed = NO;
    
    // A page is the width of the scroll view
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self numberOfPages], self.scrollView.frame.size.height);
    self.scrollView.delegate = self;
    
    pageControl.numberOfPages = [self numberOfPages];
    pageControl.currentPage = 0;
    
    // View controllers are created lazily.
    // In the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    int pageCount = [self numberOfPages];
    for (unsigned i = 0; i < pageCount; i++)
    {
        [controllers addObject:[NSNull null]];
    }
    viewControllers = controllers;
    
    // Pages are created on demand
    // Load the visible page
    // Load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];

}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageControl:nil];
    viewControllers = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self didRotateFromInterfaceOrientation:[[UIDevice currentDevice] orientation]];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self resizeScrollView];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlBeingUsed)
    {
        return;
    }
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlBeingUsed = NO;
    SGPTournamentDetailFrontViewController *controller = [viewControllers objectAtIndex:pageControl.currentPage];
    if (controller!=nil && (NSNull *)controller != [NSNull null])
    {
        [controller showFronView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView 
{
    pageControlBeingUsed = NO;
}

#pragma mark - Fetched results controller

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    Tournament *tournament = anObject;
    NSUInteger page = [[[self fetchedResultsController] fetchedObjects] indexOfObject:tournament];
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self numberOfPages], self.scrollView.frame.size.height);
            [[self pageControl] setNumberOfPages:[self numberOfPages]];
            [viewControllers addObject:[NSNull null]];
            [[self pageControl] setCurrentPage:[self numberOfPages]-1];
        } break;
        case NSFetchedResultsChangeDelete: {
            [self deletePage:indexPath.row];
        } break;
        case NSFetchedResultsChangeUpdate: {
            SGPTournamentDetailFrontViewController *tdfvc = [self tdfViewControllerForPage:page];
            if (tdfvc!=[NSNull class]) {
                [tdfvc refreshData];
            }
        } break;
    }
    
    [self changePage:nil];
    
}

@end
