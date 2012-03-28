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

#import "MUKToolkitStringTests.h"
#import "MUK+String.h"

@implementation MUKToolkitStringTests

- (void)testEnumeration {
    NSArray *brokenString = [NSArray arrayWithObjects:@"H", @"e", @"l", @"l", @"o", nil];
    NSString *string = [brokenString componentsJoinedByString:@""];
    
    __block NSInteger firstIndex = -1;    
    [MUK string:string enumerateCharactersWithOptions:0 usingBlock:^(unichar c, NSInteger index, BOOL *stop) 
    {
        if (firstIndex < 0) firstIndex = index;
        
        NSString *charString = [NSString stringWithFormat:@"%C", c];
        NSString *expectedString = [brokenString objectAtIndex:index];
        
        STAssertEqualObjects(charString, expectedString, @"Strings must match");
    }];
    STAssertEquals(firstIndex, 0, @"Enumeration must start from the beginning");
    
    firstIndex = -1;
    [MUK string:string enumerateCharactersWithOptions:MUKStringEnumerateBackwards usingBlock:^(unichar c, NSInteger index, BOOL *stop) 
     {
         if (firstIndex < 0) firstIndex = index;
         
         NSString *charString = [NSString stringWithFormat:@"%C", c];
         NSString *expectedString = [brokenString objectAtIndex:index];
         
         STAssertEqualObjects(charString, expectedString, @"Strings must match");
     }];
    STAssertEquals(firstIndex, (NSInteger)([string length]-1), @"Enumeration must start from the end");
}

- (void)testReverse {
    NSString *string = @"Hello";
    NSString *expected = @"olleH";
    
    NSString *calculated = [MUK string:string applyingTransform:MUKStringTransformReverse];
    STAssertEqualObjects(expected, calculated, nil);
}

- (void)testURLEncode {
    NSString *string = @"È bello";
    NSString *expected = @"%C3%88%20bello";
    
    NSString *calculated = [MUK string:string applyingTransform:MUKStringTransformURLEncode];
    STAssertEqualObjects(expected, calculated, nil);
}

- (void)testURLDecode {
    NSString *string = @"%C3%88%20bello";
    NSString *expected = @"È bello";
    
    NSString *calculated = [MUK string:string applyingTransform:MUKStringTransformURLDecode];
    STAssertEqualObjects(expected, calculated, nil);
}

- (void)testIdentity {
    NSString *string = @"Hello";
    NSString *expected = @"Hello";
    
    NSString *calculated = [MUK string:string applyingTransform:MUKStringTransformIdentity];
    STAssertEqualObjects(expected, calculated, nil);
    
    // Also unknown trasforms produce identity
    calculated = [MUK string:string applyingTransform:99];
    STAssertEqualObjects(expected, calculated, nil);
}

@end
