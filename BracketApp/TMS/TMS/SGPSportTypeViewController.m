//
//  SGPSportTypeViewController.m
//  TMS
//
//  Created by Jeff Morris on 5/16/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "SGPSportTypeViewController.h"

@interface SGPSportTypeViewController ()

@end

@implementation SGPSportTypeViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:NSLocalizedString(@"Sport Types", @"Sport Types")];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdent = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    [[cell textLabel] setText:[NSString stringWithFormat:@"Sport Type %d",indexPath.row+1]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
