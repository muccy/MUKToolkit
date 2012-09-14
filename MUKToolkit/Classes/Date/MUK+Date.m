// Copyright (c) 2012, Marco Muccinelli
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
// * Neither the name of the <organization> nor the
// names of its contributors may be used to endorse or promote products
// derived from this software without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "MUK+Date.h"

NSCalendarUnit const MUKDateOnlyCalendarUnits = (NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSCalendarCalendarUnit|NSTimeZoneCalendarUnit);
NSCalendarUnit const MUKDateAndTimeCalendarUnits = (MUKDateOnlyCalendarUnits|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit);

@implementation MUK (Date)

+ (NSDate *)date:(NSDate *)date normalizeUsingCalendar:(NSCalendar *)calendar units:(NSCalendarUnit)units
{
    return [self date:date transformUsingCalendar:calendar units:units withBlock:nil];
}

+ (NSDate *)date:(NSDate *)date transformUsingCalendar:(NSCalendar *)calendar units:(NSCalendarUnit)units withBlock:(NSDateComponents *(^)(NSDateComponents *))block
{
    if (!calendar) calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:units fromDate:date];
    
    NSDateComponents *transformedComponents = nil;
    if (block) {
        transformedComponents = block(components);
    }

    transformedComponents = transformedComponents ?: components;                                                                                                                                                                                                    
    return [calendar dateFromComponents:transformedComponents];
}

+ (BOOL)date:(NSDate *)date isLaterThanDate:(NSDate *)otherDate
{
    NSComparisonResult result = [date compare:otherDate];
    return (result == NSOrderedDescending);
}

+ (BOOL)date:(NSDate *)date isEarlierThanDate:(NSDate *)otherDate
{
    NSComparisonResult result = [date compare:otherDate];
    return (result == NSOrderedAscending);
}

+ (BOOL)date:(NSDate *)date isInTheSameDayOfDate:(NSDate *)otherDate usingCalendar:(NSCalendar *)calendar
{
    if (!calendar) calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components1 = [calendar components:MUKDateOnlyCalendarUnits fromDate:date];
    NSDateComponents *components2 = [calendar components:MUKDateOnlyCalendarUnits fromDate:otherDate];
    
    return (components1.year == components2.year &&
            components1.month == components2.month &&
            components1.day == components2.day);
}

@end
