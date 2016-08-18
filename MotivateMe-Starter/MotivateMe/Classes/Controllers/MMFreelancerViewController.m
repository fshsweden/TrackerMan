//
//  MMFreelancerViewController.m
//  MotivateMe
//
//  Created by Dani Arnaout on 8/17/13.
//  Copyright (c) 2013 Dani Arnaout. All rights reserved.
//

#import "MMFreelancerViewController.h"

@interface MMFreelancerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *hourRateLabel;

@end

@implementation MMFreelancerViewController

//------------------------------------------
// IBAction Methods
//------------------------------------------
#pragma mark - IBAction Methods

- (IBAction)stepperValueChanged:(UIStepper *)sender
{
    // Set hour rate label
    self.hourRateLabel.text = [NSString stringWithFormat:@"%.0f",sender.value];
}

//------------------------------------------
// Segue Methods
//------------------------------------------
#pragma mark - Segue Methods

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Save full name in user default for later use
    [[NSUserDefaults standardUserDefaults] setFloat:[self.hourRateLabel.text floatValue] forKey:HOUR_RATE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
