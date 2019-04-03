//
//  ComplicationController.m
//  Complications Extension
//
//  Created by Liandi on 2019/3/11.
//  Copyright © 2019年 Liandi. All rights reserved.
//

#import "ComplicationController.h"

@interface ComplicationController ()

@end

@implementation ComplicationController

- (void)getCurrentTimelineEntryForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimelineEntry * __nullable))handler {
    switch (complication.family) {
        case CLKComplicationFamilyModularLarge:
        {
            CLKComplicationTemplateModularLargeStandardBody *modLargeTemplate = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
            modLargeTemplate.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            modLargeTemplate.headerImageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[UIImage imageNamed:@"Complication/Modular"]];
            modLargeTemplate.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"this is a subtitle"];
            modLargeTemplate.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"this is a context"];
            CLKComplicationTimelineEntry *LargeTimeline = [CLKComplicationTimelineEntry entryWithDate:[NSDate date] complicationTemplate:modLargeTemplate];
            handler(LargeTimeline);
        }
            break;
            
        case CLKComplicationFamilyModularSmall:
        {
            CLKComplicationTemplateModularSmallStackText *modSmallTemplate = [[CLKComplicationTemplateModularSmallStackText alloc] init];
            modSmallTemplate.line1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            modSmallTemplate.line2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"this is a subtitle"];
            CLKComplicationTimelineEntry *LargeTimeline = [CLKComplicationTimelineEntry entryWithDate:[NSDate date] complicationTemplate:modSmallTemplate];
            handler(LargeTimeline);
        }
            break;
            
        case CLKComplicationFamilyCircularSmall:
        {
            CLKComplicationTemplateCircularSmallStackText *circleSmallTemplate = [[CLKComplicationTemplateCircularSmallStackText alloc] init];
            circleSmallTemplate.line1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            circleSmallTemplate.line2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"this is a subtitle"];
            CLKComplicationTimelineEntry *LargeTimeline = [CLKComplicationTimelineEntry entryWithDate:[NSDate date] complicationTemplate:circleSmallTemplate];
            handler(LargeTimeline);
        }
            break;
            
        case CLKComplicationFamilyUtilitarianSmall:
        {
            CLKComplicationTemplateUtilitarianSmallFlat *utilSmallTemplate = [[CLKComplicationTemplateUtilitarianSmallFlat alloc] init];
            utilSmallTemplate.textProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            utilSmallTemplate.imageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[UIImage imageNamed:@"Complication/Modular"]];
            CLKComplicationTimelineEntry *LargeTimeline = [CLKComplicationTimelineEntry entryWithDate:[NSDate date] complicationTemplate:utilSmallTemplate];
            handler(LargeTimeline);
        }
            break;
            
        case CLKComplicationFamilyUtilitarianLarge:
        {
            CLKComplicationTemplateUtilitarianLargeFlat *utilLargeTemplate = [[CLKComplicationTemplateUtilitarianLargeFlat alloc] init];
            utilLargeTemplate.textProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            utilLargeTemplate.imageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[UIImage imageNamed:@"Complication/Modular"]];
            CLKComplicationTimelineEntry *LargeTimeline = [CLKComplicationTimelineEntry entryWithDate:[NSDate date] complicationTemplate:utilLargeTemplate];
            handler(LargeTimeline);
        }
            break;
        case CLKComplicationFamilyGraphicCorner:
        {
            if (@available(watchOS 5.0, *)) {
                CLKComplicationTemplateGraphicCornerTextImage *cornerTextImageTemplate = [[CLKComplicationTemplateGraphicCornerTextImage alloc]init];
                cornerTextImageTemplate.textProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
                cornerTextImageTemplate.imageProvider = [CLKFullColorImageProvider providerWithFullColorImage:[UIImage imageNamed:@"Complication/Modular"]];
                CLKComplicationTimelineEntry *LargeTimeline = [CLKComplicationTimelineEntry entryWithDate:[NSDate date] complicationTemplate:cornerTextImageTemplate];
                handler(LargeTimeline);
            }
        }
            break;
        default:
            handler(nil);
            break;
    }
}

#pragma mark - Everything else, mostly stock except for refresh rate.

#pragma mark - Timeline Configuration

- (void)getSupportedTimeTravelDirectionsForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimeTravelDirections directions))handler {
    handler(CLKComplicationTimeTravelDirectionForward|CLKComplicationTimeTravelDirectionBackward);
}

- (void)getTimelineStartDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    handler([NSDate date]);
}

- (void)getTimelineEndDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    handler([NSDate dateWithTimeInterval:10*3 sinceDate:[NSDate date]]);
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication beforeDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    // Call the handler with the timeline entries prior to the given date
    handler(nil);
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication afterDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    // Call the handler with the timeline entries after to the given date
    switch (complication.family) {
            
        case CLKComplicationFamilyModularLarge:
        {
            CLKComplicationTemplateModularLargeStandardBody *modLargeTemplate1 = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
            modLargeTemplate1.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            modLargeTemplate1.headerImageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[UIImage imageNamed:@"Complication/Modular"]];
            modLargeTemplate1.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"it is lunch time"];
            modLargeTemplate1.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"it is lunch time"];
            CLKComplicationTimelineEntry *LargeTimeline1 = [CLKComplicationTimelineEntry entryWithDate:[self setCurrentlyDaySetHour:11 setMinute:38 setSec:0] complicationTemplate:modLargeTemplate1];
            
            NSLog(@"日期 ===%@",[self setCurrentlyDaySetHour:11 setMinute:38 setSec:0]);
            NSLog(@"s延迟时间 ===%@",[NSDate dateWithTimeIntervalSinceNow:10]);
            
            CLKComplicationTemplateModularLargeStandardBody *modLargeTemplate2 = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
            modLargeTemplate2.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            modLargeTemplate2.headerImageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[UIImage imageNamed:@"Complication/Modular"]];
            modLargeTemplate2.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"it is fun time"];
            modLargeTemplate2.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"it is fun time"];
            CLKComplicationTimelineEntry *LargeTimeline2 = [CLKComplicationTimelineEntry entryWithDate:[self setCurrentlyDaySetHour:12 setMinute:0 setSec:0] complicationTemplate:modLargeTemplate2];
            
            CLKComplicationTemplateModularLargeStandardBody *modLargeTemplate3 = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
            modLargeTemplate3.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            modLargeTemplate3.headerImageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[UIImage imageNamed:@"Complication/Modular"]];
            modLargeTemplate3.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"I am the coffee message"];
            modLargeTemplate3.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"I am the coffee message"];
            CLKComplicationTimelineEntry *LargeTimeline3 = [CLKComplicationTimelineEntry entryWithDate:[self setCurrentlyDaySetHour:13 setMinute:0 setSec:0] complicationTemplate:modLargeTemplate3];
            
            
            NSArray *loadTMEntry = @[LargeTimeline1,LargeTimeline2,LargeTimeline3];
            
            handler(loadTMEntry);
        }
            break;
            
        default:
            handler(nil);
            break;
    }
}
-(NSDate *)setCurrentlyDaySetHour:(NSInteger)hour setMinute:(NSInteger)minute setSec:(NSInteger)sec
{
    if (hour == 24) {//如果是24时，则是第二天的00点，所以做细微处理
        hour = 23;
        minute = 59;
        sec = 59;
    }
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    greCalendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Tokyo"];
    
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:[NSDate date]];
    
    //  定义一个NSDateComponents对象，设置一个时间点
    NSDateComponents *dateComponentsForDate = [[NSDateComponents alloc] init];
    [dateComponentsForDate setDay:dateComponents.day];
    [dateComponentsForDate setMonth:dateComponents.month];
    [dateComponentsForDate setYear:dateComponents.year];
    [dateComponentsForDate setHour:hour];
    [dateComponentsForDate setMinute:minute];
    [dateComponentsForDate setSecond:sec];
    
    NSDate *dateFromDateComponentsForDate = [greCalendar dateFromComponents:dateComponentsForDate];
    
    return dateFromDateComponentsForDate;
}

#pragma mark - Placeholder Templates

- (void)getLocalizableSampleTemplateForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTemplate * __nullable complicationTemplate))handler {
    // This method will be called once per supported complication, and the results will be cached
    switch (complication.family) {
            
            /**
             *  CLKComplicationFamilyModularLarge is the scenario where the crash occurs
             */
            
        case CLKComplicationFamilyModularLarge:
        {
            CLKComplicationTemplateModularLargeStandardBody *modLargeTemplate = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
            modLargeTemplate.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            modLargeTemplate.headerImageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[UIImage imageNamed:@"Complication/Modular"]];
            modLargeTemplate.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"this is a subtitle"];
            modLargeTemplate.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"this is a context"];
            handler(modLargeTemplate);
        }
            break;
            
        case CLKComplicationFamilyModularSmall:
        {
            CLKComplicationTemplateModularSmallStackText *modSmallTemplate = [[CLKComplicationTemplateModularSmallStackText alloc] init];
            modSmallTemplate.line1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            modSmallTemplate.line2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"this is a subtitle"];
            handler(modSmallTemplate);
        }
            break;
            
        case CLKComplicationFamilyCircularSmall:
        {
            CLKComplicationTemplateCircularSmallStackText *circleSmallTemplate = [[CLKComplicationTemplateCircularSmallStackText alloc] init];
            circleSmallTemplate.line1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            circleSmallTemplate.line2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"this is a subtitle"];
            handler(circleSmallTemplate);
        }
            break;
            
        case CLKComplicationFamilyUtilitarianSmall:
        {
            CLKComplicationTemplateUtilitarianSmallFlat *utilSmallTemplate = [[CLKComplicationTemplateUtilitarianSmallFlat alloc] init];
            utilSmallTemplate.textProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            utilSmallTemplate.imageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[UIImage imageNamed:@"Complication/Modular"]];
            handler(utilSmallTemplate);
        }
            break;
            
        case CLKComplicationFamilyUtilitarianLarge:
        {
            CLKComplicationTemplateUtilitarianLargeFlat *utilLargeTemplate = [[CLKComplicationTemplateUtilitarianLargeFlat alloc] init];
            utilLargeTemplate.textProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
            utilLargeTemplate.imageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[UIImage imageNamed:@"Complication/Modular"]];
            handler(utilLargeTemplate);
        }
            break;
        case CLKComplicationFamilyGraphicCorner:
        {
            if (@available(watchOS 5.0, *)) {
                CLKComplicationTemplateGraphicCornerTextImage *cornerTextImageTemplate = [[CLKComplicationTemplateGraphicCornerTextImage alloc]init];
                cornerTextImageTemplate.textProvider = [CLKSimpleTextProvider textProviderWithText:@"DEMO"];
                cornerTextImageTemplate.imageProvider = [CLKFullColorImageProvider providerWithFullColorImage:[UIImage imageNamed:@"Complication/Modular"]];
                handler(cornerTextImageTemplate);
            }
        }
            break;
        default:
            handler(nil);
            break;
    }
    
}

@end
