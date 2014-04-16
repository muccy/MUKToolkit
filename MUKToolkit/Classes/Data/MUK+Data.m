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

#import "MUK+Data.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MUK (Data)

+ (NSData *)data:(NSData *)data applyingTransform:(MUKDataTransform)transform
{
    if (data == nil) return nil;
    
    NSData *transformedData = data;
    
    switch (transform) {
        case MUKDataTransformSHA1: {
            unsigned char hashedChars[CC_SHA1_DIGEST_LENGTH];
            CC_SHA1([data bytes], (CC_LONG)[data length], hashedChars);
            transformedData = [NSData dataWithBytes:hashedChars length:CC_SHA1_DIGEST_LENGTH];
            break;
        }
            
        case MUKDataTransformMD5: {
            unsigned char hashedChars[CC_MD5_DIGEST_LENGTH];
            CC_MD5([data bytes], (CC_LONG)[data length], hashedChars);
            transformedData = [NSData dataWithBytes:hashedChars length:CC_MD5_DIGEST_LENGTH];
            break;
        }
            
        default:
            break;
    }
    
    return transformedData;
}

+ (void)data:(NSData *)data enumerateBytesUsingBlock:(void (^)(unsigned char const, NSInteger, BOOL *))block
{
    if (!data || !block) return;
    unsigned char const *bytes = [data bytes];
    
    for (NSInteger i=0; i<[data length]; i++) {
        BOOL stop = NO;
        block(bytes[i], i, &stop);
        
        if (stop) break;
    } // for
}

@end
