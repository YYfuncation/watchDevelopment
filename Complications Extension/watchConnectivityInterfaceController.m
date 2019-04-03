//
//  watchConnectivityInterfaceController.m
//  Complications Extension
//
//  Created by Liandi on 2019/3/18.
//  Copyright © 2019年 Liandi. All rights reserved.
//

#import "watchConnectivityInterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface watchConnectivityInterfaceController ()<WCSessionDelegate>

@end

@implementation watchConnectivityInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}
- (IBAction)clickTo {
    if ([[WCSession defaultSession] isReachable])
    {
        [[WCSession defaultSession] sendMessage:@{@"event" : @"I am from the apple watch"}
                                   replyHandler:^(NSDictionary *replyHandler) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           NSLog(@"replyHandler = %@", replyHandler);
                                       });
                                   }
                                   errorHandler:^(NSError *error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           NSLog(@"error = %@", error);
                                       });
                                   }
         ];
    }
}
- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error {
    
}
- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



