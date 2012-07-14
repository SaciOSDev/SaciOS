//
//  JSONtestViewController.h
//  JSONtest
//
//  Created by Morris, Jeffrey on 4/13/11.
//  Copyright 2011 JDMDesign.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface JSONtestViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate> {
    UITableView *tableView;
    NSMutableData *receivedData;
    NSFetchedResultsController *_frc;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSFetchedResultsController *frc;

- (NSFetchedResultsController*)frc;

- (IBAction)refreshFromServer:(id)sender;
- (IBAction)createNewEntry:(id)sender;
- (IBAction)createNewRecordWithData:(NSDictionary*)data;

@end
