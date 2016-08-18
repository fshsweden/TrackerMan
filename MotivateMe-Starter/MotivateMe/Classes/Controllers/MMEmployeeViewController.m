//
//  MMEmployeeViewController.m
//  MotivateMe
//
//  Created by Dani Arnaout on 8/17/13.
//  Copyright (c) 2013 Dani Arnaout. All rights reserved.
//

#import "MMEmployeeViewController.h"

#define AVERAGE_WORKING_DAYS_PER_MONTH 22

@interface MMEmployeeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *monthlyIncomeTextField;
@property (weak, nonatomic) IBOutlet UITextField *workingHoursPerDayTextField;

@end

@implementation MMEmployeeViewController

//------------------------------------------
// Private Methods
//------------------------------------------
#pragma mark - Private Methods

/*
 This method calculates an estimate value for an hourly rate by dividing monthly salary on working hours per day multiplied that with the number of working days per month.
 */
-(float) calculateHourRateFromSalary:(NSInteger) salary workingHoursPerDay:(NSInteger) hours
{
    return (float)salary/(hours*AVERAGE_WORKING_DAYS_PER_MONTH);
    
}

//------------------------------------------
// IBAction Methods
//------------------------------------------
#pragma mark - IBAction Methods

/*
 A transparant button is used to resign keyboard when screen is touched
 */
- (IBAction)backgroundButtonTouchUpInside
{
    // Resign keyboard
    [self.view endEditing:YES];
}

//------------------------------------------
// Segue Methods
//------------------------------------------
#pragma mark - Segue Methods

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get salary & working hours values from text fields
    NSInteger salary = [self.monthlyIncomeTextField.text integerValue];
    NSInteger workingHours = [self.workingHoursPerDayTextField.text integerValue];

    // Save hour rate in user default for later use
    [[NSUserDefaults standardUserDefaults] setFloat:[self calculateHourRateFromSalary:salary workingHoursPerDay:workingHours] forKey:HOUR_RATE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
