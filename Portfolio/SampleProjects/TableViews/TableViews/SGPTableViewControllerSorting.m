//
//  SGPTableViewControllerSorting.m
//  TableViews
//
//  Created by Jeff Morris on 5/29/12.
//  Copyright (c) 2012 JDMdesign.com. All rights reserved.
//

#import "SGPTableViewControllerSorting.h"

@interface SGPTableViewControllerSorting ()
@property bool showIndent;
@end

@implementation SGPTableViewControllerSorting

@synthesize showIndent;

- (void)option:(id)sender {
    showIndent = !showIndent;
    self.editing = !self.editing;
    if (showIndent) {
        [(UIBarButtonItem*)sender setTitle:@"Hide Indent"];
    } else {
        [(UIBarButtonItem*)sender setTitle:@"Show Indent"];        
    }
    [[self tableView] reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsSelection = YES;
    self.tableView.editing = YES;
    showIndent = YES;
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Hide Indent" 
                                                            style:UIBarButtonItemStyleBordered 
                                                           target:self 
                                                           action:@selector(option:)];
    [[self navigationItem] setRightBarButtonItem:btn];
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
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    // Configure the cell...
    [[cell textLabel] setText:[NSString stringWithFormat:@"Sec: %d Row: %d",indexPath.section,indexPath.row]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row<=1);
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return NO;
//}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return showIndent;
}

@end
