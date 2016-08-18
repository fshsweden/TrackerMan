//
//  MMMotivatorViewController.m
//  MotivateMe
//
//  Created by Dani Arnaout on 8/17/13.
//  Copyright (c) 2013 Dani Arnaout. All rights reserved.
//

#import "MMMotivatorViewController.h"
#import "MMFullNameViewController.h"

#define FULL_NAME_SEGUE_IDENTIFIER @"fullNameSegue"

@interface MMMotivatorViewController ()

// Labels
@property (weak, nonatomic) IBOutlet UILabel *todayDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *earnedMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *earnedWorkingTimeLabel;

// Buttons
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (assign, nonatomic) NSInteger earnedWorkingSeconds;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation MMMotivatorViewController

//------------------------------------------
// App Life Cycle
//------------------------------------------
#pragma mark - App Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setDateLabel];
    [self updateCurrentWorkingTimeLabel];
   
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:USERNAME_KEY])
    {
       // This is the app's first launch. Present modal with setup screens
        [self performSegueWithIdentifier:FULL_NAME_SEGUE_IDENTIFIER sender:nil];
    }
    
    // Set up navigation item title
    self.title = [[NSUserDefaults standardUserDefaults] objectForKey:USERNAME_KEY];
}

//------------------------------------------
// Private Methods
//------------------------------------------
#pragma mark - Private Methods

/*
 This method sets the date label on top of the screen by today's date.
 */
-(void)setDateLabel
{
    // Get current date
    NSDate *date = [NSDate date];
    
    // Get current calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSYearCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    
    // Create date components
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSInteger year = [components year];
    NSInteger day = [components day];
    
    // Get month
    NSDateFormatter *month = [[NSDateFormatter alloc] init];
    [month setDateFormat:@"MMMM"];
    
    // Get week day
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEE"];
    
    // Set label with today's date
    self.todayDateLabel.text = [NSString stringWithFormat:@"%@, %i %@ %i",[weekDay stringFromDate:date], day, [month stringFromDate:date], year];
}


/*
 This method gets called each second to update current working hours time label.
 Calcualtions are done to convert total number of seconds to hours, minutes, & seconds.
 */
-(void) updateCurrentWorkingTimeLabel
{
    int seconds = self.earnedWorkingSeconds;
    int hours = seconds / (60 * 60);
    seconds -= hours * (60 * 60);
    int minutes = seconds / 60;
    seconds -= minutes * 60;
    
    self.earnedWorkingTimeLabel.text = [NSString stringWithFormat:@"%i hr %i min %i sec",hours,minutes,seconds];
}


/*
 This method updates money & time labels by doing some calculations.
 */
-(void)updateUI
{
    self.earnedWorkingSeconds++;
    
    // Calculate money earned
    float moneyEarned = (float)self.earnedWorkingSeconds*[[NSUserDefaults standardUserDefaults] floatForKey:HOUR_RATE_KEY]/3600;
    
    // Update money label
    self.earnedMoneyLabel.text = [NSString stringWithFormat:@"%.2f$",moneyEarned];
    
    // Update time label
    [self updateCurrentWorkingTimeLabel];
}

//------------------------------------------
// IBAction Methods
//------------------------------------------
#pragma mark - IBAction Methods

/*
 This method is triggered when start button is pressed.
 It fires a timer to keep on update UI every second.
 */
- (IBAction)startButtonEventTouchUpInside
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
   
    self.startButton.enabled = NO;
    self.pauseButton.enabled = YES;
    self.stopButton.enabled = YES;
}

/*
 This method is used to pause current values without resetting.
 */
- (IBAction)pauseButtonEventTouchUpInside
{
    [self.timer invalidate];
   
    self.startButton.enabled = YES;
    self.pauseButton.enabled = NO;
    self.stopButton.enabled = YES;
}

/*
 This method resets all values. It gives the user a fresh new start.
 */
- (IBAction)stopButtonEventTouchUpInside
{
    // Reset UI
    [self.timer invalidate];
    self.earnedWorkingSeconds = -1;
    [self updateUI];
   
    self.startButton.enabled = YES;
    self.pauseButton.enabled = NO;
    self.stopButton.enabled = NO;
    
}
@end
