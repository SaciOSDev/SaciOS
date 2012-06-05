//
//  SGPTableViewControllerCellTypes.m
//  TableViews
//
//  Created by Jeff Morris on 5/29/12.
//  Copyright (c) 2012 JDMdesign.com. All rights reserved.
//

#import "SGPTableViewControllerCellTypes.h"

@interface SGPTableViewControllerCellTypes ()

@end

@implementation SGPTableViewControllerCellTypes

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdent = @"UITableViewCellStyleDefault";
    UITableViewCellStyle cellType = UITableViewCellStyleDefault;
    
    switch (indexPath.row) {
        case 1: {
            cellIdent = @"UITableViewCellStyleSubtitle";
            cellType = UITableViewCellStyleSubtitle;
        } break;
        case 2: {
            cellIdent = @"UITableViewCellStyleValue1";
            cellType = UITableViewCellStyleValue1;
        } break;
        case 3: {
            cellIdent = @"UITableViewCellStyleValue2";
            cellType = UITableViewCellStyleValue2;
        } break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:cellType reuseIdentifier:cellIdent];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    // Configure the cell...
    [[cell imageView] setImage:[UIImage imageNamed:@"icon.png"]];
    [[cell textLabel] setText:cellIdent];
    [[cell detailTextLabel] setText:@"Detail View"];
    
    return cell;
}

@end
