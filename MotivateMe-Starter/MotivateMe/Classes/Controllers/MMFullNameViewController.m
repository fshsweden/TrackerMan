//
//  MMFullNameViewController.m
//  MotivateMe
//
//  Created by Dani Arnaout on 8/17/13.
//  Copyright (c) 2013 Dani Arnaout. All rights reserved.
//

#import "MMFullNameViewController.h"

@interface MMFullNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *fullNameTextField;
@end

@implementation MMFullNameViewController

//------------------------------------------
// Segue Methods
//------------------------------------------
#pragma mark - Segue Methods

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Save full name in user default for later use
    [[NSUserDefaults standardUserDefaults] setObject:self.fullNameTextField.text forKey:USERNAME_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
