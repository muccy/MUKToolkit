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

#import "MUKToolkitBaseTests.h"
#import "MUK.h"
#import "MUK+Date.h"

@implementation MUKToolkitBaseTests

- (void)testBitmaskFlag {
    NSUInteger flag = (1<<2);
    NSUInteger bitmask = (1<<5 | 1<<0);
    
    STAssertFalse([MUK bitmask:bitmask containsFlag:flag], @"%i not contained in %i", flag, bitmask);
    
    bitmask = (bitmask | flag);
    STAssertTrue([MUK bitmask:bitmask containsFlag:flag], @"%i contained in %i", flag, bitmask);
}

- (void)testWaitForCompletion {
    __block BOOL resultsDone = NO;
    NSTimeInterval timeout = 2.0;
    
    double delayInSeconds = timeout * 0.5;
    __block NSDate *asyncCompletionDate = nil;
    dispatch_queue_t asyncQueue = dispatch_queue_create("it.melive.mukit.muktoolikit.tests.base.waitforcompletion", NULL);
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, asyncQueue, ^(void){  
        // Call into main queue in order to wake up run loop
        dispatch_async(dispatch_get_main_queue(), ^{
            asyncCompletionDate = [NSDate date];
            resultsDone = YES;
        });
    });
    
    // It will return before timeout
    NSDate *waitStartDate = [NSDate date];
    BOOL done = [MUK waitForCompletion:&resultsDone timeout:timeout runLoop:nil];
    
    STAssertTrue(done, @"No timeout");
    STAssertNotNil(asyncCompletionDate, @"Completed");
    STAssertTrue([MUK date:asyncCompletionDate isLaterThanDate:waitStartDate], @"Completion date comes after wait start date");
    
    ////////////////////////////////////
    // No timeout
    resultsDone = NO;
    asyncCompletionDate = nil;
    popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, asyncQueue, ^(void){  
        // Call into main queue in order to wake up run loop
        dispatch_async(dispatch_get_main_queue(), ^{
            asyncCompletionDate = [NSDate date];
            resultsDone = YES;
        });
    });
    
    waitStartDate = [NSDate date];
    done = [MUK waitForCompletion:&resultsDone timeout:-1.0 runLoop:nil];
    
    STAssertTrue(done, @"No timeout");
    STAssertNotNil(asyncCompletionDate, @"Completed");
    STAssertTrue([MUK date:asyncCompletionDate isLaterThanDate:waitStartDate], @"Completion date comes after wait start date");
    
    ////////////////////////////////////
    // Timeout
    resultsDone = NO;
    asyncCompletionDate = nil;
    delayInSeconds = timeout * 1.5;
    popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, asyncQueue, ^(void){  
        // Call into main queue in order to wake up run loop
        dispatch_async(dispatch_get_main_queue(), ^{
            asyncCompletionDate = [NSDate date];
            resultsDone = YES;
        });
    });
    
    waitStartDate = [NSDate date];
    done = [MUK waitForCompletion:&resultsDone timeout:timeout runLoop:nil];
    
    STAssertFalse(done, @"Timeout fired");
    STAssertNil(asyncCompletionDate, @"Not completed");
    
    dispatch_release(asyncQueue);
}

@end
