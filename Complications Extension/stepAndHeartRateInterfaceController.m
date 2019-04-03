//
//  stepAndHeartRateInterfaceController.m
//  Complications Extension
//
//  Created by Liandi on 2019/3/18.
//  Copyright © 2019年 Liandi. All rights reserved.
//

#import "stepAndHeartRateInterfaceController.h"
#import <HealthKit/HealthKit.h>
#import <CoreMotion/CoreMotion.h>

@interface stepAndHeartRateInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *stepLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *rateLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *heartBtn;
@property (nonatomic, strong) HKHealthStore *healStore;
@property (nonatomic, strong) CMPedometer *pedometer;
@property (nonatomic, strong) HKAnchoredObjectQuery *heartRateQuery;
@property (nonatomic, assign) BOOL isStart;
@end

@implementation stepAndHeartRateInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)getSteps {
    [self getStep:^(NSInteger stepCount) {
        [self.stepLabel setText:[NSString stringWithFormat:@"歩数：%d", stepCount]];
    }];
}
- (IBAction)getHeartRate {
    if (!self.isStart) {
        [self.rateLabel setText:@"正在检测心跳..."];
        [self getHeartRate:^(NSInteger heartRate) {
            [self.rateLabel setText:[NSString stringWithFormat:@"心拍：%d count/min", heartRate]];
            self.isStart = YES;
            [self.heartBtn setTitle:@"结束"];
        }];
    } else {
        [self.healStore stopQuery:self.heartRateQuery];
        self.isStart = NO;
        [self.heartBtn setTitle:@"开始"];
        [self.rateLabel setText:@"心拍"];
    }
}
- (void)getStep:(void (^)(NSInteger stepCount))callback {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Tokyo"];
    NSDate *currentDate = NSDate.date;
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate: currentDate];
    //    components.day -= 2;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [calendar dateFromComponents:components];
    //    NSDate *fromDate = [dateFormatter dateFromString:@"2019-03-06 00:00:00"];
    NSDate *endDate  = [NSDate date];
    
    NSDate *dateAtStartOfDay = [calendar dateFromComponents:components];
    NSDate *dateAtEndOfDay = currentDate;
    
    HKStatisticsCollectionQuery* queryH = [self queryStepHourSumWithAnchorFromDate:startDate
                                                                            toDate:endDate];
    __block NSInteger totalStep = 0;
    // 统计总值
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount] quantitySamplePredicate:queryH.predicate options:queryH.options completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error) {
        HKQuantity *quantity = result.sumQuantity;
        totalStep = [quantity doubleValueForUnit:[HKUnit countUnit]];
        NSLog(@"step = %i, startDate = %@, endDate = %@", totalStep, result.startDate.description, result.endDate.description);
        callback(totalStep);
    }];
    
    // 统计每一段的总值
    HKStatisticsCollectionQuery *execQuery =  [[HKStatisticsCollectionQuery alloc]
                                               initWithQuantityType: [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]
                                               quantitySamplePredicate:queryH.predicate
                                               options:queryH.options
                                               anchorDate:queryH.anchorDate
                                               intervalComponents:queryH.intervalComponents];
    execQuery.initialResultsHandler = ^(HKStatisticsCollectionQuery *query,
                                        HKStatisticsCollection * _Nullable result,
                                        NSError * _Nullable error) {
        
        [result enumerateStatisticsFromDate:dateAtStartOfDay
                                     toDate:dateAtEndOfDay
                                  withBlock:^(HKStatistics *result, BOOL *stop) {
                                      HKQuantity *quantity = result.sumQuantity;
                                      double step = [quantity doubleValueForUnit:[HKUnit countUnit]];
                                      NSLog(@"step = %f, startDate = %@, endDate = %@", step, result.startDate.description, result.endDate.description);
                                      totalStep += step;
                                  }];
        callback(totalStep);
    };
    [[HKHealthStore new] executeQuery:query];
    /**
     *  // 通过加速器和陀螺仪获取步数，局限：只能获取5个小时之内的数据
     if ([CMPedometer isStepCountingAvailable]) {
     
     [self.pedometer queryPedometerDataFromDate:dateAtStartOfDay toDate:dateAtEndOfDay withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
     if (error) {
     NSLog(@"错误原因：%@", error.localizedDescription);
     } else {
     NSLog(@"开始时间：%@", pedometerData.startDate);
     NSLog(@"结束时间：%@", pedometerData.endDate);
     NSLog(@"步数===%@",pedometerData.numberOfSteps);
     NSLog(@"距离===%@m",pedometerData.distance);
     }
     }];
     } else {
     NSLog(@"陀螺仪和加速仪不可用");
     }
     */
}

- (void)getHeartRate:(void (^)(NSInteger heartRate))callback {
    /**
     *  获取某个时间段的心率，历史心率
     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
     calendar.timeZone = [NSTimeZone timeZoneWithName:TokyoTimeZone];
     NSDate *currentDate = NSDate.date;
     NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate: currentDate];
     components.day -= 2;
     NSDate *dateAtStartOfDay = [calendar dateFromComponents:components];
     NSDate *dateAtEndOfDay = currentDate;
     NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:dateAtStartOfDay endDate:dateAtEndOfDay options:HKQueryOptionNone];
     */
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:[NSDate date] endDate:nil options:HKQueryOptionNone]; // 实时获取心率，延迟5秒
    HKQueryAnchor *anchor = [HKQueryAnchor anchorFromValue:HKAnchoredObjectQueryNoAnchor];
    
    self.heartRateQuery = [[HKAnchoredObjectQuery alloc] initWithType:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate] predicate:predicate anchor:anchor limit:HKObjectQueryNoLimit resultsHandler:^(HKAnchoredObjectQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable sampleObjects, NSArray<HKDeletedObject *> * _Nullable deletedObjects, HKQueryAnchor * _Nullable newAnchor, NSError * _Nullable error) {
        for (HKSample *sample in sampleObjects) {
            NSLog(@"start : %@", sample.description);
        }
    }];
    
    [self.heartRateQuery setUpdateHandler:^(HKAnchoredObjectQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable addedObjects, NSArray<HKDeletedObject *> * _Nullable deletedObjects, HKQueryAnchor * _Nullable newAnchor, NSError * _Nullable error) {
        for (HKSample *sample in addedObjects) {
            NSLog(@"update : %@", sample.description);
        }
        HKQuantitySample *quantitySample = addedObjects.lastObject;
        if (quantitySample) {
            HKUnit *heartRateUnit = [HKUnit unitFromString:@"count/min"];
            double heartRate = [quantitySample.quantity doubleValueForUnit:heartRateUnit];
            callback(heartRate);
        }
    }];
    
    [self.healStore executeQuery:self.heartRateQuery];
    
}

-(HKStatisticsCollectionQuery*)queryStepHourSumWithAnchorFromDate:(NSDate*)fromDate
                                                           toDate:(NSDate*)toDate
{
    HKQuantityType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
    intervalComponents.hour = 1;
    intervalComponents.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Tokyo"];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:fromDate endDate:toDate options:HKQueryOptionNone];
    //    NSPredicate *updatePred = [self createDataSourcePredicateWithBasePredicate: predicate];
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc]
                                          initWithQuantityType:type
                                          quantitySamplePredicate:predicate
                                          options:HKStatisticsOptionCumulativeSum
                                          anchorDate:fromDate
                                          intervalComponents:intervalComponents];
    return query;
}


#pragma mark - lazy
- (CMPedometer *)pedometer {
    if (!_pedometer) {
        _pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
}

- (HKHealthStore *)healStore {
    if (!_healStore) {
        _healStore = [[HKHealthStore alloc] init];
    }
    return _healStore;
}
@end



