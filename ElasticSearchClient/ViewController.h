//
//  ViewController.h
//  Example
//
//  Created by Pulkit Singhal on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface ViewController : UIViewController <RKObjectLoaderDelegate>

@property (weak, nonatomic) IBOutlet UILabel *protocol;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *port;
@property (weak, nonatomic) IBOutlet UILabel *index; // not shown in XIB yet?

@property (weak, nonatomic) IBOutlet UITextView *request;
@property (weak, nonatomic) IBOutlet UITextView *response;

@property (weak, nonatomic) IBOutlet UIButton *testQueryStringButton;
@property (weak, nonatomic) IBOutlet UIButton *testBoolWithQueryStringButton;
@property (weak, nonatomic) IBOutlet UIButton *testBoolWithRangeQueryButton;

- (IBAction) testQueryStringQuery : (id) sender;
- (IBAction) testBoolQueryWithNestedQueryStringQuery : (id) sender;
- (IBAction) testBoolQueryWithNestedRangeQuery : (id) sender;

@end
