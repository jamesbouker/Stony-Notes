//
//  NSDate+Category.m
//  StonyNotes
//
//  Created by Jimmy on 1/26/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

-(BOOL)isToday {
    NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    if([today day] == [otherDay day] &&
       [today month] == [otherDay month] &&
       [today year] == [otherDay year] &&
       [today era] == [otherDay era]) {
        return YES;
    }
    return NO;
}

@end
