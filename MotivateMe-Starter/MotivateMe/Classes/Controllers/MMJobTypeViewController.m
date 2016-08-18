//
//  MMJobTypeViewController.m
//  MotivateMe
//
//  Created by Dani Arnaout on 8/23/13.
//  Copyright (c) 2013 Dani Arnaout. All rights reserved.
//

#import "MMJobTypeViewController.h"

#define FREELANCER_IDENTIFIER @"freelancer"

@implementation MMJobTypeViewController

//------------------------------------------
// Segue Methods
//------------------------------------------
#pragma mark - Segue Methods

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Save job type in user default for later use
    if ([segue.identifier isEqualToString:FREELANCER_IDENTIFIER])
    {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:JOB_TYPE_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    else
    {
        // Employee option was chosen
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:JOB_TYPE_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
