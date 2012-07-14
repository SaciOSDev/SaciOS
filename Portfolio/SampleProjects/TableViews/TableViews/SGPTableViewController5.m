//
//  SGPTableViewController5.m
//  TableViews
//
//  Created by Jeff Morris on 5/29/12.
//  Copyright (c) 2012 JDMdesign.com. All rights reserved.
//

#import "SGPTableViewController5.h"

@interface SGPTableViewController5 ()
@property bool showHeader;
@end

@implementation SGPTableViewController5

@synthesize showHeader;

- (void)option:(id)sender {
    showHeader = !showHeader;
    if (showHeader) {
        [(UIBarButtonItem*)sender setTitle:@"Hide Headers"];
    } else {
        [(UIBarButtonItem*)sender setTitle:@"Show Headers"];        
    }
    [[self tableView] reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    showHeader = NO;
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Show Headers" 
                                                            style:UIBarButtonItemStyleBordered 
                                                           target:self 
                                                           action:@selector(option:)];
    [[self navigationItem] setRightBarButtonItem:btn];
    
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    [header setText:@"Table Header"];
    [header setTextAlignment:UITextAlignmentCenter];
    [header setBackgroundColor:[UIColor yellowColor]];
    [[self tableView] setTableHeaderView:header];    
    
    UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    [footer setText:@"Footer Header"];
    [footer setTextAlignment:UITextAlignmentCenter];
    [footer setBackgroundColor:[UIColor yellowColor]];
    [[self tableView] setTableFooterView:footer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdent = @"cellIdent";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    // Configure the cell...
    [[cell textLabel] setText:[NSString stringWithFormat:@"Sec: %d Row: %d",indexPath.section,indexPath.row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return (showHeader) ? [NSString stringWithFormat:@"Section Header: %d",section] : @"";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return (showHeader) ? [NSString stringWithFormat:@"Section Footer: %d",section] : @"";
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
