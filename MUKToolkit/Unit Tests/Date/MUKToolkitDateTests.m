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

#import "MUKToolkitDateTests.h"
#import "MUK+Date.h"

@implementation MUKToolkitDateTests

- (void)testTransform {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *distantDate = [NSDate distantFuture];
    NSCalendarUnit units = MUKDateOnlyCalendarUnits;
    
    const NSInteger expectedYear = 2001, expectedMonth = 5, expectedDay = 11;
    NSDate *transformedDate = [MUK date:distantDate transformUsingCalendar:calendar units:units withBlock:^NSDateComponents *(NSDateComponents *components) 
    {
        components.year = expectedYear;
        components.month = expectedMonth;
        components.day = expectedDay;
        return components;
    }];
    
    NSDateComponents *components = [calendar components:units fromDate:transformedDate];
    STAssertEquals(expectedYear, components.year, @"Years should match");
    STAssertEquals(expectedMonth, components.month, @"Months should match");
    STAssertEquals(expectedDay, components.day, @"Days should match");
}

- (void)testIdentity {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *distantDate = [NSDate distantFuture];
    NSCalendarUnit units = MUKDateAndTimeCalendarUnits;
    
    NSDateComponents *distantComponents = [calendar components:units fromDate:distantDate];
    
    NSDate *transformedDate = [MUK date:distantDate transformUsingCalendar:calendar units:units withBlock:nil];
    NSDateComponents *components = [calendar components:units fromDate:transformedDate];
    
    STAssertEquals(distantComponents.year, components.year, @"Years should match");
    STAssertEquals(distantComponents.month, components.month, @"Months should match");
    STAssertEquals(distantComponents.day, components.day, @"Days should match");
    STAssertEquals(distantComponents.hour, components.hour, @"Hours should match");
    STAssertEquals(distantComponents.minute, components.minute, @"Months should match");
    STAssertEquals(distantComponents.second, components.second, @"Seconds should match");
}

- (void)testTruncation {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *distantDate = [NSDate distantFuture];
    
    NSDate *truncatedDate = [MUK date:distantDate normalizeUsingCalendar:calendar units:MUKDateOnlyCalendarUnits];
    
    NSDateComponents *distantComponents = [calendar components:MUKDateAndTimeCalendarUnits fromDate:distantDate];
    NSDateComponents *components = [calendar components:MUKDateAndTimeCalendarUnits fromDate:truncatedDate];
    
    STAssertEquals(components.year, distantComponents.year, @"Years should match");
    STAssertEquals(components.month, distantComponents.month, @"Months should match");
    STAssertEquals(components.day, distantComponents.day, @"Days should match");
    STAssertEquals(components.hour, (NSInteger)0, @"Hours should be truncated");
    STAssertEquals(components.minute, (NSInteger)0, @"Months should be truncated");
    STAssertEquals(components.second, (NSInteger)0, @"Seconds should be truncated");
}

- (void)testComparisons {
    NSDate *now = [NSDate date];
    
    NSDate *laterDate = [now dateByAddingTimeInterval:10.0];
    NSDate *veryLaterDate = [now dateByAddingTimeInterval:60.0*60.0*24.0*7.0];
    NSDate *earlierDate = [now dateByAddingTimeInterval:-10.0];
    NSDate *sameDate = [now dateByAddingTimeInterval:0.0];
    
    STAssertTrue([MUK date:now isEarlierThanDate:laterDate], @"now comes before laterDate");
    STAssertFalse([MUK date:now isLaterThanDate:laterDate], @"now comes before laterDate");
    
    STAssertTrue([MUK date:now isLaterThanDate:earlierDate], @"now comes after earlierDate");
    STAssertFalse([MUK date:now isEarlierThanDate:earlierDate], @"now comes after earlierDate");
    
    STAssertTrue([MUK date:now isInTheSameDayOfDate:sameDate usingCalendar:nil], @"Same dates are in the same day");
    STAssertFalse([MUK date:now isInTheSameDayOfDate:veryLaterDate usingCalendar:nil], @"Very different dates are in different days");
    
    STAssertFalse([MUK date:now isLaterThanDate:sameDate], @"Same date doesn't come after now");
    STAssertFalse([MUK date:now isEarlierThanDate:sameDate], @"Same date doesn't come before now");
}

@end
