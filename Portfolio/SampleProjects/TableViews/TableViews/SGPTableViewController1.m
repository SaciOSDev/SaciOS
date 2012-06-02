//
//  SGPTableViewController1.m
//  TableViews
//
//  Created by Jeff Morris on 5/29/12.
//  Copyright (c) 2012 Pearson. All rights reserved.
//

#import "SGPTableViewController1.h"

@interface SGPTableViewController1 ()

@end

@implementation SGPTableViewController1

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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

@end
