//
//  MMSettingsViewController.m
//  MotivateMe
//
//  Created by Dani Arnaout on 8/17/13.
//  Copyright (c) 2013 Dani Arnaout. All rights reserved.
//

#import "MMSettingsViewController.h"

@interface MMSettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *hourRateTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *jobTypeSegmentedControl;

@end

@implementation MMSettingsViewController

//------------------------------------------
// App Life Cycle
//------------------------------------------
#pragma mark - App Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load saved values for full name & hour rate
    self.fullNameTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERNAME_KEY];
    self.hourRateTextField.text = [NSString stringWithFormat:@"%.0f",[[NSUserDefaults standardUserDefaults] floatForKey:HOUR_RATE_KEY]];
    self.jobTypeSegmentedControl.selectedSegmentIndex = [[NSUserDefaults standardUserDefaults] integerForKey:JOB_TYPE_KEY];
}

//------------------------------------------
// IBAction Methods
//------------------------------------------
#pragma mark - IBAction Methods

- (IBAction)sendFeedbackButtonEventTouchUpInside
{
    // TestFlight Feedback
}

- (IBAction)saveButtonEventTouchUpInside:(UIBarButtonItem *)sender
{
    // Save value to user defaults
    [[NSUserDefaults standardUserDefaults] setObject:self.fullNameTextField.text forKey:USERNAME_KEY];
    [[NSUserDefaults standardUserDefaults] setFloat:[self.hourRateTextField.text floatValue] forKey:HOUR_RATE_KEY];
    [[NSUserDefaults standardUserDefaults] setInteger:self.jobTypeSegmentedControl.selectedSegmentIndex forKey:JOB_TYPE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Dismiss modal view controller
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)cancelButtonEventTouchUpInside:(UIBarButtonItem *)sender
{
    // Dismiss modal view controller
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)crashButtonEventTouchUpInside
{

}
@end
