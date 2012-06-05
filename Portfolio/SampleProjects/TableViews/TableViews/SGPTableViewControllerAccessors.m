//
//  SGPTableViewControllerAccessors.m
//  TableViews
//
//  Created by Jeff Morris on 5/29/12.
//  Copyright (c) 2012 JDMdesign.com. All rights reserved.
//

#import "SGPTableViewControllerAccessors.h"

@interface SGPTableViewControllerAccessors ()

@end

@implementation SGPTableViewControllerAccessors

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdent = @"cellIdent";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    
    // Configure the cell...
    switch (indexPath.row) {
        case 0: {
            [[cell textLabel] setText:@"None"];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        } break;
        case 1: {
            [[cell textLabel] setText:@"Checkmark"];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } break;
        case 2: {
            [[cell textLabel] setText:@"DisclosureIndicator"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        } break;
        case 3: {
            [[cell textLabel] setText:@"DetailDisclosureButton"];
            [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
        } break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [[[UIAlertView alloc] initWithTitle:@"Accessory Tapped" 
                                message:[NSString stringWithFormat:@"Accessor at section %d for row %d was tapped!",indexPath.section,indexPath.row] 
                               delegate:nil 
                      cancelButtonTitle:@"OK" 
                      otherButtonTitles:nil] show];
}

@end
