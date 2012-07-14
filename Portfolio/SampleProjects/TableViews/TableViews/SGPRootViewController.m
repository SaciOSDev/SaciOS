//
//  SGPRootViewController.m
//  TableViews
//
//  Created by Jeff Morris on 5/29/12.
//  Copyright (c) 2012 JDMdesign.com. All rights reserved.
//

#import "SGPRootViewController.h"

#import "SGPTableViewController1.h"

@interface SGPRootViewController ()

@end

@implementation SGPRootViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 5;
        case 1: return 5;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdent = @"cellIdent";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    // Configure the cell...    
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: [[cell textLabel] setText:@"Basic Table (Group)"]; break;
                case 1: [[cell textLabel] setText:@"Multiple Sections (Group)"]; break;
                case 2: [[cell textLabel] setText:@"Section Headers/Footer (Group)"]; break;
                case 3: [[cell textLabel] setText:@"Table Headers/Footers (Group)"]; break;
                case 4: [[cell textLabel] setText:@"Table Headers/Footers (Plain)"]; break;
                default: [[cell textLabel] setText:@"Not Used Yet"]; break;
            }        
        } break;
        case 1: {
            switch (indexPath.row) {
                case 0: [[cell textLabel] setText:@"Cell Types (Plain)"]; break;
                case 1: [[cell textLabel] setText:@"Accessory Buttons (Plain)"]; break;
                case 2: [[cell textLabel] setText:@"Edit States (Group)"]; break;
                case 3: [[cell textLabel] setText:@"Sorting (Plain)"]; break;
                case 4: [[cell textLabel] setText:@"Custom Cells (TBD)"]; break;
                default: [[cell textLabel] setText:@"Not Used Yet"]; break;
            }
        } break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Configure the cell...
    NSString *className = @"SGPTableViewController";
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: className = [NSString stringWithFormat:@"%@1",className]; break;
                case 1: className = [NSString stringWithFormat:@"%@2",className]; break;
                case 2: className = [NSString stringWithFormat:@"%@3",className]; break;
                case 3: className = [NSString stringWithFormat:@"%@4",className]; break;
                case 4: className = [NSString stringWithFormat:@"%@5",className]; break;
                default: className = [NSString stringWithFormat:@"%@1",className]; break;
            }
        } break;
        case 1: {
            switch (indexPath.row) {
                case 0: className = @"SGPTableViewControllerCellTypes"; break;
                case 1: className = @"SGPTableViewControllerAccessors"; break;
                case 2: className = @"SGPTableViewControllerEditing"; break;
                case 3: className = @"SGPTableViewControllerSorting"; break;
                case 4: className = [NSString stringWithFormat:@"%@5",className]; break;
                default: className = [NSString stringWithFormat:@"%@1",className]; break;
            }
        } break;
    }
    
    UITableViewController *vc = [[NSClassFromString(className) alloc] initWithNibName:className bundle:nil];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [vc setTitle:[[cell textLabel] text]];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
