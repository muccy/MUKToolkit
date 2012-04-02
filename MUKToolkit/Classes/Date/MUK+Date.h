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

#import "MUK.h"

extern NSCalendarUnit const MUKDateOnlyCalendarUnits;
extern NSCalendarUnit const MUKDateAndTimeCalendarUnits;

/** 
 Methods involving dates.
 
 ## Constants
 
 `MUKDateOnlyCalendarUnits` defines a bitmask of `NSCalendarUnit` suitable to
 inspect the date without time components.
     NSCalendarUnit const MUKDateOnlyCalendarUnits = (NSEraCalendarUnit|
            NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|
            NSCalendarCalendarUnit|NSTimeZoneCalendarUnit);
 
 `MUKDateAndTimeCalendarUnits` defines a bitmask of `NSCalendarUnit` suitable to
 inspect the date including time components.
     NSCalendarUnit const MUKDateAndTimeCalendarUnits = (MUKDateOnlyCalendarUnits|
            NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|
            NSSecondCalendarUnit);
 
 */
@interface MUK (Date)
/**
 Transform a given date into another, manipulating its date components.
 @param date Date to be transformed.
 @param calendar Calendar to use to calculate dates. If `nil` it uses `[NSCalendar currentCalendar]`.
 @param units A bitmask of `NSNSCalendarUnit` used to extract date components.
 @param block A block which takes `NSDateComponents` extracted with given `units`
 and returns `NSDateComponents` used to computed transformed date.
 If you feed `nil` instead of a block or block returns `nil`, original components
 are used.
 @return Trasformed date applying `units` and `block`.
 */
+ (NSDate *)date:(NSDate *)date transformUsingCalendar:(NSCalendar *)calendar units:(NSCalendarUnit)units withBlock:(NSDateComponents * (^)(NSDateComponents *components))block;
/**
 Truncate components from a given date.
 @param date Date to be normalized.
 @param calendar Calendar to use to calculate dates. If `nil` it uses `[NSCalendar currentCalendar]`.
 @param units A bitmask of `NSNSCalendarUnit` used to extract date components. If
 you do not specify a unit, it will be truncated.
 @return A date including only components given in `unit` parameter.
 */
+ (NSDate *)date:(NSDate *)date normalizeUsingCalendar:(NSCalendar *)calendar units:(NSCalendarUnit)units;
/**
 Shortend to discover if a date comes after other one.
 @param date Base date in comparison.
 @param otherDate Compared date.
 @return YES if `date` comes after `otherDate`.
 */
+ (BOOL)date:(NSDate *)date isLaterThanDate:(NSDate *)otherDate;
/**
 Shortend to discover if a date comes before other one.
 @param date Base date in comparison.
 @param otherDate Compared date.
 @return YES if `date` comes before `otherDate`.
 */
+ (BOOL)date:(NSDate *)date isEarlierThanDate:(NSDate *)otherDate;
/**
 Discover if two dates have the same year/month/day.
 @param date Base date in comparison.
 @param otherDate Compared date.
 @param calendar Calendar to use to calculate dates. If `nil` it uses `[NSCalendar currentCalendar]`.
 @return YES if `date` has the same year/month/day of `otherDate`.
 */
+ (BOOL)date:(NSDate *)date isInTheSameDayOfDate:(NSDate *)otherDate usingCalendar:(NSCalendar *)calendar;

@end
