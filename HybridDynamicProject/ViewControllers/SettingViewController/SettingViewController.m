//
//  SettingViewController.m
//  almasryalyoum
//
//  Created by MohamedMansour on 9/21/14.
//  Copyright (c) 2014 Sarmady.net. All rights reserved.
//

#import "SettingViewController.h"
#import <Pushbots/Pushbots.h>
@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)changeNotificationSwitch:(id)sender {
    NSData* deviceID = [[NSUserDefaults standardUserDefaults] objectForKey:@"PushbotsDDId"];
  
    if (self.notificationSwitch.isOn==NO) {
        [[Pushbots getInstance] unregister];
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"PushbotsReg"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"PushbotsReg"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[Pushbots getInstance] RegisterDeviceToken:deviceID ];
        
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* PushbotsReg = [[NSUserDefaults standardUserDefaults] objectForKey:@"PushbotsReg"];
    if ([PushbotsReg isEqualToString:@"YES"]) {
        [self.notificationSwitch setOn:YES];
    }
    else{
     [self.notificationSwitch setOn:NO];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
