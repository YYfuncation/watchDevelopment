//
//  ViewController.m
//  watchComplications
//
//  Created by Liandi on 2019/3/11.
//  Copyright © 2019年 Liandi. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)pushLocationNotification:(id)sender {
    if (@available(iOS 10.0, *)) {
        UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:@"Test" arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:@"test local notification"
                                                             arguments:nil];
        content.sound = [UNNotificationSound soundNamed:UILocalNotificationDefaultSoundName];
        content.subtitle = [NSString localizedUserNotificationStringForKey:@"SubTest" arguments:nil];// ios use
        
        content.categoryIdentifier = @"myLocationCategory";
        
        // 每5秒发送本地通知
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        
        // Create the request object.
        UNNotificationRequest* request = [UNNotificationRequest
                                          requestWithIdentifier:@"TestLocalNotification" content:content trigger:trigger];
        
        UNUserNotificationCenter *unCenter = [UNUserNotificationCenter currentNotificationCenter];
        [unCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"local notification error：%@", [error localizedDescription]);
            }
        }];
    }
    
}

- (IBAction)pushLocationNotifitionStatic:(id)sender {
    if (@available(iOS 10.0, *)) {
        UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:@"Test" arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:@"test local notification"
                                                             arguments:nil];
        content.subtitle = [NSString localizedUserNotificationStringForKey:@"SubTest" arguments:nil];// ios use
        content.sound = [UNNotificationSound soundNamed:UILocalNotificationDefaultSoundName];
        
        // 每5秒发送本地通知
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        
        // Create the request object.
        UNNotificationRequest* request = [UNNotificationRequest
                                          requestWithIdentifier:@"TestLocalNotification" content:content trigger:trigger];
        
        UNUserNotificationCenter *unCenter = [UNUserNotificationCenter currentNotificationCenter];
        [unCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"local notification error：%@", [error localizedDescription]);
            }
        }];
    } 
    
}

@end
