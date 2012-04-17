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

#import <Foundation/Foundation.h>

/**
 `MUK` is not a class you need to instantiate: it is only the namespace where
 toolkit methods live.
 
 This toolkit do not want to *pollute* system namespaces with categories, but
 exposes a set of class methods.
 
 See various categories:
 
 * MUK(Generic)
 * MUK(Array)
 * MUK(Data)
 * MUK(Date)
 * MUK(Geometry)
 * MUK(Object)
 * MUK(String)
 * MUK(URL)
 
 */
@interface MUK : NSObject
@end

/**
 Generic methods.
 */
@interface MUK (Generic)
/**
 Discover if a value is flagged into bitmask.
 @param bitmask The bitmask where flag is searched.
 @param flag The value searched in the bitmask.
 @return YES if flag bit is found into bitmask.
 */
+ (BOOL)bitmask:(NSUInteger)bitmask containsFlag:(NSUInteger)flag;
/**
 Runs run loop, waiting for a signal which wakes it.
 
 Example:
 
    // t = 0
    __block BOOL resultsReady = NO;
 
    // Dispatch a long operation async...
    dispatch_async(asyncQueue, ^(void) {
        TimeConsumingRoutine();
    
        dispatch_async(dispatch_get_main_queue(), ^{
            // Call on main queue to wake waiting run loop
            resultsReady = YES;
        });
    });
 
    // Wait on current run loop 
    BOOL done = [MUK waitForCompletion:&resultsReady timeout:60.0 runLoop:nil];
    
    // Wait finished...
    if (done) {
        // t' = t + LongSyncFunction background execution time
    }
    else {
        // t' = t + 60.0 (timeout)
    }
 
 @param done A pointer to a `BOOL`. You can assign `YES` to pointed value
 in order to signal completion.
 @param timeout Maximum time inverval before this method returns. You could
 specify negative timeout in order not to use a timeout at all.
 @param runLoop Run loop where to wait. Leave this parameter `nil` to use
 `[NSRunLoop currentRunLoop]`.
 @return `YES` if method returned because done signal; `NO` if method
 returned because of timeout.
 @warning Not setting a timeout could make this method waiting forever.
 @warning You have to wake runLoop in order to make this method return. You
 can invoke a method, using 
 `[NSRunLoop performSelector:target:argument:order:modes:]` to do so.
 Because you often use this method on main thread you can use
 `dispatch_async` on main queue or 
 `[NSObject performSelectorOnMainThread:withObject:waitUntilDone:]`.
 */
+ (BOOL)waitForCompletion:(BOOL *)done timeout:(NSTimeInterval)timeout runLoop:(NSRunLoop *)runLoop;
@end