//
//  SGPTournamentViewController.m
//  TMS
//
//  Created by Jeff Morris on 5/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPTournamentViewController.h"
#import "SGPCreateTournamentViewController.h"
#import "AwesomeMenuItem.h"

@interface SGPTournamentViewController ()

@end

@implementation SGPTournamentViewController

@synthesize tournament;
@synthesize menu;

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *menus = [NSArray arrayWithObjects:
                      [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Back.png"]
                                            highlightedImage:[UIImage imageNamed:@"Back.png"] 
                                                ContentImage:nil
                                     highlightedContentImage:nil],
                      [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Details.png"]
                                            highlightedImage:[UIImage imageNamed:@"Details.png"] 
                                                ContentImage:nil
                                     highlightedContentImage:nil],
                      [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Flex.png"]
                                            highlightedImage:[UIImage imageNamed:@"Flex.png"] 
                                                ContentImage:nil
                                     highlightedContentImage:nil],
                      [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Reseed.png"]
                                            highlightedImage:[UIImage imageNamed:@"Reseed.png"] 
                                                ContentImage:nil
                                     highlightedContentImage:nil],
                      [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"AddRemove.png"]
                                            highlightedImage:[UIImage imageNamed:@"AddRemove.png"] 
                                                ContentImage:nil
                                     highlightedContentImage:nil],
                      nil];

    CGRect frame = self.view.frame;
    [self setMenu:[[AwesomeMenu alloc] initWithFrame:CGRectMake(0, frame.size.height-200, 200, 200) menus:menus]];
    [[self menu] setAutoresizingMask: UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin];
    [self menu].startPoint = CGPointMake(32.0, self.menu.bounds.size.height-32.0);
    [self menu].rotateAngle = 0.0f;
    [self menu].menuWholeAngle = M_PI / 1.6;
    [self menu].farRadius = 140.0f;
    [self menu].nearRadius = 120.0f;
    [self menu].endRadius = 130.0f;
    [self menu].delegate = self;
        
    [[self view] addSubview:[self menu]];
}

- (void)viewDidUnload
{
    [self setTournament:nil];
    [super viewDidUnload];
}

#pragma mark - AwesomeMenuDelegate

- (void)AwesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
    switch (idx) {
        case 0: {
            [[self navigationController] popViewControllerAnimated:YES];
        } break;
        case 1: {
            SGPCreateTournamentViewController *vc = [[SGPCreateTournamentViewController alloc] initWithNibName:@"SGPCreateTournamentViewController" bundle:nil];
            [vc setManagedObjectContext:[self managedObjectContext]];
            [vc setTournament:[self tournament]];
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
            [nvc setModalPresentationStyle:UIModalPresentationFormSheet];
            [[self navigationController] presentModalViewController:nvc animated:YES];  
        } break;
        case 2: {
            
        } break;
        case 3: {
            
        } break;
        default:
            break;
    }
}

@end
