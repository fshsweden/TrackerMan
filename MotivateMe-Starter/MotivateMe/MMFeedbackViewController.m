//
//  MMFeedbackViewController.m
//  MotivateMe
//
//  Created by Dani Arnaout on 8/17/13.
//  Copyright (c) 2013 Dani Arnaout. All rights reserved.
//

#import "MMFeedbackViewController.h"

@interface MMFeedbackViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;

@end

@implementation MMFeedbackViewController

//------------------------------------------
// App Life Cycle
//------------------------------------------
#pragma mark - App Life Cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.feedbackTextView becomeFirstResponder];
}

//------------------------------------------
// IBAction Methods
//------------------------------------------
#pragma mark - IBAction Methods

- (IBAction)sendButtonEventTouchUpInside:(UIBarButtonItem *)sender
{

    // Alert user for successful sending
    [[[UIAlertView alloc] initWithTitle:@"Sent" message:@"Feedback sent successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
