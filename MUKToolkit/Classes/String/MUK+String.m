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

#import "MUK+String.h"

@implementation MUK (String)

+ (void)string:(NSString *)string enumerateCharactersWithOptions:(MUKStringOptions)options usingBlock:(void (^)(unichar c, NSInteger index, BOOL *stop))enumerator
{
    NSUInteger len = [string length];
    
    if (len > 0 && enumerator) {
        if ([self bitmask:options containsFlag:MUKStringEnumerateBackwards]) {
            for (NSInteger i = len-1; i >= 0; i--) {
                unichar c = [string characterAtIndex:i];
                
                BOOL stop = NO;
                enumerator(c, i, &stop);
                
                if (stop) break;
            } // for
        }
        else {
            for (NSInteger i = 0; i < len; i++) {
                unichar c = [string characterAtIndex:i];
                
                BOOL stop = NO;
                enumerator(c, i, &stop);
                
                if (stop) break;
            } // for
        }
    }
}

+ (NSString *)string:(NSString *)string applyingTransform:(MUKStringTransform)transform
{
    NSString *output = string;
    
    switch (transform) {
        case MUKStringTransformReverse: {
            NSInteger len = [string length];
            if (len > 0) {
                NSMutableString *mutString = [NSMutableString stringWithCapacity:len];
                [self string:string enumerateCharactersWithOptions:MUKStringEnumerateBackwards usingBlock:^(unichar c, NSInteger index, BOOL *stop) 
                {
                    [mutString appendFormat:@"%C", c];
                }];
                
                output = mutString;
            }

            break;
        }
            
        case MUKStringTransformURLEncode: {
            output = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
            break;
        }
          
        case MUKStringTransformURLDecode: {
            output = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, CFSTR(""));
            break;
        }
            
        default:
            break;
    }
    
    return output;
}

@end