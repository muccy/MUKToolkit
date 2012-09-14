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

#import "MUKToolkitArrayTests.h"
#import "MUK+Array.h"

@implementation MUKToolkitArrayTests

- (void)testObjectAtIndex {
    NSArray *array = [NSArray arrayWithObject:@"Hello"];
    
    STAssertNoThrow([MUK array:array objectAtIndex:0], @"+array:objectAtIndex: never throws exceptions");
    STAssertNoThrow([MUK array:array objectAtIndex:-100], @"+array:objectAtIndex: never throws exceptions");
    STAssertNoThrow([MUK array:array objectAtIndex:100], @"+array:objectAtIndex: never throws exceptions");
    
    STAssertNotNil([MUK array:array objectAtIndex:0], @"Should return at item");
    STAssertNil([MUK array:array objectAtIndex:-100], @"Should not return at item");
    STAssertNil([MUK array:array objectAtIndex:100], @"Should not return at item");
}

- (void)testMapping {
    NSArray *array = [NSArray arrayWithObjects:@"hello", @"world", @"this", @"is", @"me", nil];
    NSArray *expectedArray = [NSArray arrayWithObjects:@"HELLO", @"WORLD", @"THIS", @"IS", @"ME", nil];
    
    NSArray *mappedArray = [MUK array:array map:^id(id obj, NSInteger index, BOOL *exclude, BOOL *stop) 
    {
        return [obj uppercaseString];
    }];
    STAssertEqualObjects(mappedArray, expectedArray, @"Arrays should match");
    
    // Nil
    expectedArray = [NSArray arrayWithObjects:[NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null], nil];
    mappedArray = [MUK array:array map:^id(id obj, NSInteger index, BOOL *exclude, BOOL *stop) 
    {
        return nil;
    }];
    STAssertEqualObjects(mappedArray, expectedArray, @"Arrays should match");
    
    // Exclude
    expectedArray = [NSArray arrayWithObjects:@"world", @"is", nil];
    mappedArray = [MUK array:array map:^id(id obj, NSInteger index, BOOL *exclude, BOOL *stop)
    {
        *exclude = (index % 2 == 0);
        return obj;
    }];
    STAssertEqualObjects(mappedArray, expectedArray, @"Arrays should match");
    
    // Stopping
    expectedArray = [NSArray arrayWithObjects:@"hello", @"world", nil];
    mappedArray = [MUK array:array map:^id(id obj, NSInteger index, BOOL *exclude, BOOL *stop)
    {
        *stop = (index >= 2);
        return obj;
    }];
    STAssertEqualObjects(mappedArray, expectedArray, @"Arrays should match");
}

- (void)testIdentityTransform {
    NSArray *array = @[];
    NSArray *output = [MUK array:array applyingTransform:MUKArrayTransformIdentity];
    STAssertEqualObjects(output, array, nil);
    
    array = @[@1, @2, @3];
    output = [MUK array:array applyingTransform:MUKArrayTransformIdentity];
    STAssertEqualObjects(output, array, nil);
}

- (void)testReverseTransform {
    NSArray *array = @[];
    NSArray *expected = @[];
    NSArray *output = [MUK array:array applyingTransform:MUKArrayTransformReverse];
    STAssertEqualObjects(output, expected, nil);
    
    array = @[@1, @2, @3];
    expected = @[@3, @2, @1];
    output = [MUK array:array applyingTransform:MUKArrayTransformReverse];
    STAssertEqualObjects(output, expected, nil);
}

@end
