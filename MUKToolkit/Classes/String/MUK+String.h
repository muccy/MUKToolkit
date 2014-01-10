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


typedef enum : NSUInteger {
    MUKStringTransformIdentity = 0,
    MUKStringTransformReverse,
    MUKStringTransformURLEncode,
    MUKStringTransformURLDecode,
    MUKStringTransformUppercaseFirstLetter,
    MUKStringTransformSHA1,
    MUKStringTransformMD5,
    MUKStringTransformNormalize
} MUKStringTransform;

typedef enum : NSUInteger {
    MUKStringEnumerationNormal = 0,
    MUKStringEnumerationBackwards = 1
} MUKStringEnumerationOptions;

/**
 Methods involving strings.

 ## Constants
 
 ### MUKStringTransform
 
 `MUKStringTransform` enumerates kinds of transform you can apply to a 
 string:
 
 * `MUKStringTransformIdentity` returns string untouched.
 * `MUKStringTransformReverse` reverses the string.
 * `MUKStringTransformURLEncode` URL encode the string.
 * `MUKStringTransformURLDecode` URL decode the string.
 * `MUKStringTransformUppercaseFirstLetter` turns first letter of the string to uppercase. 
 * `MUKStringTransformSHA1` returns SHA-1 hash of the string.
 * `MUKStringTransformMD5` returns MD5 hash of the string.
 * `MUKStringTransformNormalize` returns a normalized string (Unicode normalization,
 case normalization, diacritics normalization, character width distinctions normalization).
 You could use this method to save normalized strings to Core Data fields, ready
 to be searched with `BEGINSWITH[n]` (see https://devforums.apple.com/message/363871#363871 )
 
 ### MUKStringEnumerationOptions
 
 `MUKStringEnumerationOptions` enumerates options you can use during
 enumeration:
 
 * `MUKStringEnumerationNormal` means no option.
 * `MUKStringEnumerationBackwards` means enumeration will run backwards.
 
 */
@interface MUK (String)
/**
 It enumerates characters in a string.
 @param string String to enumerate.
 @param options Set to `MUKStringEnumerationBackwards` if you want to enumerate 
 given string backwards. Otherwise set to `0`.
 @param enumerator A block which takes an `unichar`, which is the enumerated
 character, a `NSInteger`, which is the index of the character in the string,
 and a `BOOL *`, which is useful if you want to break enumeration.
 */
+ (void)string:(NSString *)string enumerateCharactersWithOptions:(MUKStringEnumerationOptions)options usingBlock:(void (^)(unichar c, NSInteger index, BOOL *stop))enumerator;
/**
 It transforms a given string.
 
 You can perform a transform per time (`transform` is not a bitmask):
 
 @param string String to transform.
 @param transform Kind of trasform to be applied to the given string.
 @return A string produced applying transform on given string.
 */
+ (NSString *)string:(NSString *)string applyingTransform:(MUKStringTransform)transform;
/**
 Hexadecimal (`%02x`) representation of bytes contained in data.
 @param data Data to convert to hex.
 @return String hex representation (lowercase).
 */
+ (NSString *)stringHexadecimalRepresentationOfData:(NSData *)data;
/**
 Converts time interval to a string in the format `hh:mm:ss`.
 
 Negative intervals are displayed with `-` as prefix.
 
 If timeInterval is less than `3600` (an hour) format is `minutes:seconds` 
 (e.g.: `61` is converted to `01:01`).
 
 If timeInterval is greater than `3600` (an hour) format is `hh:mm:ss`
 (e.g.: `3601` is converted to `01:00:01`).
 
 @param timeInterval Time inverval to convert.
 @return String representation of timeInterval.
 */
+ (NSString *)stringRepresentationOfTimeInterval:(NSTimeInterval)timeInterval;

@end
