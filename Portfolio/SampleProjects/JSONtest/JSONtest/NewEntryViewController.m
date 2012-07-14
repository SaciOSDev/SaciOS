//
//  NewEntryViewController.m
//  JSONtest
//
//  Created by Morris, Jeffrey on 5/25/11.
//  Copyright 2011 JDMDesign.com. All rights reserved.
//

#import "NewEntryViewController.h"

@implementation NewEntryViewController

@synthesize titleTextField;
@synthesize descriptTextView;
@synthesize jsonViewController;
@synthesize dBRecord;

- (void)cancelNewEntry {
    if (self.dBRecord!=nil) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController dismissModalViewControllerAnimated:YES];        
    }
}

- (void)saveNewEntry {
    if (jsonViewController!=nil) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        if (self.dBRecord!=nil) [data setObject:self.dBRecord.serverId forKey:@"id"];
        if (self.titleTextField.text!=nil) {
            [data setObject:self.titleTextField.text forKey:@"title"];  
        } else {
            [data setObject:@"" forKey:@"title"];
        }
        if (self.descriptTextView.text!=nil) {
            [data setObject:self.descriptTextView.text forKey:@"descript"];  
        } else {
            [data setObject:@"" forKey:@"descript"];
        }
        [jsonViewController createNewRecordWithData:data];
        [data release];
        [self cancelNewEntry];
    }
}

- (void)dealloc {
    [titleTextField release];
    [descriptTextView release];
    jsonViewController = nil;
    [dBRecord release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"New Entry";
    self.titleTextField.text = nil;
    [self.titleTextField becomeFirstResponder];
    self.descriptTextView.text = nil;
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancelNewEntry)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                            target:self
                                                                                           action:@selector(saveNewEntry)] autorelease];
}

- (void)viewDidUnload {
    [self setTitleTextField:nil];
    [self setDescriptTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.dBRecord!=nil) {
        self.titleTextField.text = [self.dBRecord.title copy];
        self.descriptTextView.text = [self.dBRecord.descript copy];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
