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
    MUKArrayTransformIdentity   =   0,
    MUKArrayTransformReverse
} MUKArrayTransform;

/**
 Methods involving arrays.
 
 ## Constants
 
 ### MUKArrayTransform
 
 `MUKArrayTransform` enumerates kinds of transform you can apply to an
 array:
 * `MUKArrayTransformIdentity` returns array untouched.
 * `MUKArrayTransformReverse` reverses the array.
 
 */
@interface MUK (Array)
/**
 Returns objects from array safely, without raising exceptions when `index` is
 out of bounds.
 @param array Array to query.
 @param index Index of desired object into `array`. If index is out of bounds,
 no expection is raised.
 @return Object at given `index` or `nil` if `index` is out of bounds.
 */
+ (id)array:(NSArray *)array objectAtIndex:(NSInteger)index;
/**
 Map an array with a block.
 
 This method takes a `block` which accepts:
 
 * `obj`, an object contained into given `array`.
 * `index`, index of `obj` into given `array`.
 * `*exclude`, pointer to `BOOL` that you could set to `YES` not to include this
 object into returned array.
 * `*stop`, pointer to `BOOL` that you could set to `YES` to stop mapping and
 to return an array mapped until previous iteration.
 
 This `block` should return an object which will be inserted into resulting
 mapped array. If you return `nil` from this block, you will find a corresponding
 `[NSNull null]` object.
 
 @param array Array to map.
 @param block A block which returns an object mapped on an object contained into
 given `array`.
 @return Given `array` mapped with `block`.
 */
+ (NSArray *)array:(NSArray *)array map:(id (^)(id obj, NSInteger index, BOOL *exclude, BOOL *stop))block;
/**
 It transforms a given array.
 
 You can perform a transform per time (`transform` is not a bitmask):
 
 @param array Array to transform.
 @param transform Kind of trasform to be applied to the given array.
 @return An array produced applying transform on given array.
 */
+ (NSArray *)array:(NSArray *)array applyingTransform:(MUKArrayTransform)transform;

@end
