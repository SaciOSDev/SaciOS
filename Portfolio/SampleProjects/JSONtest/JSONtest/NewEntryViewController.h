//
//  NewEntryViewController.h
//  JSONtest
//
//  Created by Morris, Jeffrey on 5/25/11.
//  Copyright 2011 JDMDesign.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONtestViewController.h"
#import "DBRecord.h"

@interface NewEntryViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate> {
    UITextField *titleTextField;
    UITextView *descriptTextView;
    JSONtestViewController *jsonViewController;
    DBRecord *dBRecord;
}

@property (nonatomic, retain) IBOutlet UITextField *titleTextField;
@property (nonatomic, retain) IBOutlet UITextView *descriptTextView;
@property (nonatomic, assign) JSONtestViewController *jsonViewController;
@property (nonatomic, retain) DBRecord *dBRecord; 

@end
