//
//  SGPBaseViewController.h
//  TMS
//
//  Created by Jeff Morris on 4/30/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPBaseManagedObject.h"

@interface SGPBaseViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property Class managedObjectClass;
@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSPredicate *predicate;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)cancelModalView:(id)sender;

@end
