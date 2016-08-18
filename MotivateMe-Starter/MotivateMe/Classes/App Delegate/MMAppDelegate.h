//
//  MMAppDelegate.h
//  MotivateMe
//
//  Created by Dani Arnaout on 8/17/13.
//  Copyright (c) 2013 Dani Arnaout. All rights reserved.
//

#import <UIKit/UIKit.h>

#define USERNAME_KEY @"username"
#define HOUR_RATE_KEY @"hourRate"
#define JOB_TYPE_KEY @"jobType"
#define FIRST_TIME_LAUNCH_KEY @"firstTimeLaunch"

@interface MMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
