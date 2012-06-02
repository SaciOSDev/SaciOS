//
//  SGPTableViewControllerEditing.m
//  TableViews
//
//  Created by Jeff Morris on 5/29/12.
//  Copyright (c) 2012 Pearson. All rights reserved.
//

#import "SGPTableViewControllerEditing.h"

@interface SGPTableViewControllerEditing ()
@property int rowCount;
@end

@implementation SGPTableViewControllerEditing

@synthesize rowCount;

- (void)option:(id)sender {
    self.tableView.editing = !self.tableView.editing;
    if (self.tableView.editing) {
        [(UIBarButtonItem*)sender setTitle:@"Done"];
    } else {
        [(UIBarButtonItem*)sender setTitle:@"Edit"];        
    }
    [[self tableView] reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rowCount = 5;
    self.tableView.editing = NO;
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Edit" 
                                                            style:UIBarButtonItemStyleBordered 
                                                           target:self 
                                                           action:@selector(option:)];
    [[self navigationItem] setRightBarButtonItem:btn];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)configureCell:(UITableViewCell*)cell withIndexPath:(NSIndexPath*)indexPath {
    [[cell textLabel] setText:[NSString stringWithFormat:@"Sec: %d Row: %d",indexPath.section,indexPath.row]];
    if (indexPath.row % 2) {
        [cell setBackgroundColor:[UIColor darkGrayColor]];
    } else {
        [cell setBackgroundColor:[UIColor lightGrayColor]];        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdent = @"cellIdent";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    // Configure the cell...
    [self configureCell:cell withIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return UITableViewCellEditingStyleNone;
    } else if (indexPath.row+1==[self tableView:tableView numberOfRowsInSection:indexPath.section]) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row<2) {
        return @"Meow";
    } else {
        return nil;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row!=0);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (editingStyle) {
        case UITableViewCellEditingStyleNone:
            [[[UIAlertView alloc] initWithTitle:@"UITableViewCellEditingStyleNone" 
                                        message:@"UITableViewCellEditingStyleNone"
                                       delegate:nil 
                              cancelButtonTitle:@"OK" 
                              otherButtonTitles:nil] show];
            break;
            
        case UITableViewCellEditingStyleDelete:
            [[[UIAlertView alloc] initWithTitle:@"UITableViewCellEditingStyleDelete" 
                                        message:@"UITableViewCellEditingStyleDelete"
                                       delegate:nil 
                              cancelButtonTitle:@"OK" 
                              otherButtonTitles:nil] show];
            break;
            
        case UITableViewCellEditingStyleInsert:
            self.rowCount += 1;
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withIndexPath:indexPath];
            [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.rowCount-1 inSection:indexPath.section]] 
                                    withRowAnimation:UITableViewRowAnimationRight];
//            [[[UIAlertView alloc] initWithTitle:@"UITableViewCellEditingStyleInsert" 
//                                        message:@"UITableViewCellEditingStyleInsert"
//                                       delegate:nil 
//                              cancelButtonTitle:@"OK" 
//                              otherButtonTitles:nil] show];
            [tableView performSelector:@selector(reloadData) withObject:nil afterDelay:1.0];
            NSTimeInterval time = 0.0f;
            break;
        default:
            break;
    }
}

@end
