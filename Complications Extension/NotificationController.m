//
//  NotificationController.m
//  Complications Extension
//
//  Created by Liandi on 2019/3/11.
//  Copyright © 2019年 Liandi. All rights reserved.
//

#import "NotificationController.h"


@interface NotificationController ()

@end


@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        //        NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
        //        [self.movie setMovieURL:[NSURL fileURLWithPath:moviePath]];
        //        [self.movie playFromBeginning];
        
        
//        UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
//        content.title = [NSString localizedUserNotificationStringForKey:@"Test" arguments:nil];
//        content.body = [NSString localizedUserNotificationStringForKey:@"test local notification from AppleWatch"
//                                                             arguments:nil];
//        content.subtitle = [NSString localizedUserNotificationStringForKey:@"SubTest" arguments:nil];// ios use
//        content.sound = [UNNotificationSound defaultSound];
//
//        // 每5秒发送本地通知
//        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
//
//        NSString *requestIdentifier = [NSString stringWithFormat:@"localNotification%i", arc4random_uniform(1000) + 1];
//
//        // Create the request object.
//        UNNotificationRequest* request = [UNNotificationRequest
//                                          requestWithIdentifier:requestIdentifier content:content trigger:trigger];
//
//        UNUserNotificationCenter *unCenter = [UNUserNotificationCenter currentNotificationCenter];
//        [unCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
//            if (error) {
//                NSLog(@"local notification error：%@", [error localizedDescription]);
//            }
//        }];
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)didReceiveNotification:(UNNotification *)notification {
    // This method is called when a notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
}

@end



