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

#import "MUKToolkitDataTests.h"
#import "MUK+Data.h"
#import "MUK+String.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MUKToolkitDataTests

- (void)testBytesEnumeration {
    NSInteger const bytesCount = 5;
    
    // Alloc bytes on heap to use them in blocks
    unsigned char *bytes = calloc(bytesCount, sizeof(unsigned char const));
    bytes[0] = 'h';
    bytes[1] = 'e';
    bytes[2] = 'l';
    bytes[3] = 'l';
    bytes[4] = '0';
    
    NSData *data = [NSData dataWithBytes:bytes length:bytesCount];
    
    __block NSInteger hits = 0;
    [MUK data:data enumerateBytesUsingBlock:^(const unsigned char byte, NSInteger index, BOOL *stop) 
    {
        const unsigned char expectedByte = bytes[index];
        STAssertEquals(expectedByte, byte, @"Bytes must match");
        
        hits++;
    }];
    STAssertEquals(hits, bytesCount, @"Block should be called for every byte");
    
    NSInteger const stopAtIndex = 2;
    hits = 0;
    [MUK data:data enumerateBytesUsingBlock:^(const unsigned char byte, NSInteger index, BOOL *stop) 
     {
         *stop = (index >= stopAtIndex);
         hits++;
     }];
    STAssertEquals(stopAtIndex, hits-1, @"Stop should work properly");
    
    free(bytes);
}

- (void)testIdentity {
    NSData *data = [@"Hello" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *transformedData = [MUK data:data applyingTransform:MUKDataTransformIdentity];
    STAssertEqualObjects(data, transformedData, @"Identic data must match");
}

- (void)testSHA1 {
    NSData *data = [@"Hello" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *expectedHash = @"f7ff9e8b7bb2e09b70935a5d785e0cc5d9d0abf0";
    
    NSData *transformedData = [MUK data:data applyingTransform:MUKDataTransformSHA1];
    STAssertEqualObjects(expectedHash, [MUK stringHexadecimalRepresentationOfData:transformedData], @"SHA1 of 'Hello' is '%@'", expectedHash);
}

- (void)testMD5 {
    NSData *data = [@"Hello" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *expectedHash = @"8b1a9953c4611296a827abf8c47804d7";
    
    NSData *transformedData = [MUK data:data applyingTransform:MUKDataTransformMD5];
    STAssertEqualObjects(expectedHash, [MUK stringHexadecimalRepresentationOfData:transformedData], @"MD5 of 'Hello' is '%@'", expectedHash);
}

@end
