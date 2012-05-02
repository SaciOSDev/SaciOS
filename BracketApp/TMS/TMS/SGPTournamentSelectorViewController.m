//
//  SGPTournamentSelectorViewController.m
//  TMS
//
//  Created by Jeff Morris on 4/30/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPTournamentSelectorViewController.h"
#import "SGPTournamentDetailFrontViewController.h"

#define PADDING     25

@interface SGPTournamentSelectorViewController ()

@end

@implementation SGPTournamentSelectorViewController

@synthesize scrollView;
@synthesize pageControl;

#pragma mark - Private Methods

- (IBAction)showTournament:(id)sender
{
    NSLog(@"TODO - Show Tournament Here!");
}

- (int)numberOfPages {
    return 7;
}

- (void)loadScrollViewWithPage:(int)page {
    
    if (page < 0) return;
    if (page >= [self numberOfPages]) return;
    
    // Replace the placeholder if necessary
    SGPTournamentDetailFrontViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[SGPTournamentDetailFrontViewController alloc] initWithPageNumber:page];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    // Add the controller's view to the scroll view
    if (controller.view.superview == nil) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page + PADDING;
        frame.origin.y = 0 + PADDING;
        frame.size.width -= PADDING*2;
        frame.size.height -= PADDING*2;
        controller.view.frame = frame;
        [self.scrollView addSubview:controller.view];
    }
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
    
}

- (IBAction)deleteTournament:(id)sender
{

}

- (IBAction)exportTournament:(id)sender
{

}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    for (unsigned i = 0; i < pageCount; i++) {
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

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    rotatePageStart = pageControl.currentPage;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self numberOfPages], self.scrollView.frame.size.height);
        
    // Now reset the coordinates of each bulletin in the list of viewControllers
    int pageCount = 0 ;
    for (UIViewController *vc in viewControllers) {
        if ((NSNull *)vc != [NSNull null]) {
            CGRect frame = self.scrollView.frame;
            frame.origin.x = frame.size.width * pageCount + PADDING;
            frame.origin.y = 0 + PADDING;
            frame.size.width -= PADDING*2;
            frame.size.height -= PADDING*2;
            vc.view.frame = frame;
        }
        pageCount++;
    }
    
    // Now, update the scroll view to the appropriate page
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * rotatePageStart;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:NO];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlBeingUsed) {
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

@end
