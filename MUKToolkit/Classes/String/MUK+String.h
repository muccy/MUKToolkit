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

typedef enum {
    MUKStringTransformIdentity = 0,
    MUKStringTransformReverse,
    MUKStringTransformURLEncode,
    MUKStringTransformURLDecode
} MUKStringTransform;

typedef enum {
    MUKStringEnumerateBackwards = 1
} MUKStringOptions;

@interface MUK (String)
/**
 It enumerates characters in a string.
 @param string String to enumerate.
 @param options Set to `MUKStringEnumerateBackwards` if you want to enumerate 
 given string backwards. Otherwise set to `0`.
 @param enumerator A block which takes an `unichar`, which is the enumerated
 character, a `NSInteger`, which is the index of the character in the string,
 and a `BOOL *`, which is useful if you want to break enumeration.
 */
+ (void)string:(NSString *)string enumerateCharactersWithOptions:(MUKStringOptions)options usingBlock:(void (^)(unichar c, NSInteger index, BOOL *stop))enumerator;
/**
 It transforms a given string.
 
 You can perform a transform per time (`transform` is not a bitmask):
 
 * `MUKStringTransformIdentity` returns string untouched.
 * `MUKStringTransformReverse` reverses the string.
 * `MUKStringTransformURLEncode` URL encode the string.
 * `MUKStringTransformURLDecode` URL decode the string.
 
 @param string String to transform.
 @param transform Kind of trasform to be applied to the given string.
 @return A string produced applying transform on given string.
 */
+ (NSString *)string:(NSString *)string applyingTransform:(MUKStringTransform)transform;

@end
