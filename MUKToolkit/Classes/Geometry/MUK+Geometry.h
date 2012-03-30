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

/** 
 ## Geometry Constants
 
 `MUKGeometricDimension` is an enumeration used to compose bitmasks of geometric
 dimensions:
 
 * `MUKGeometricDimensionX`, represents X coordinate.
 * `MUKGeometricDimensionY`, represents Y coordinate.
 * `MUKGeometricDimensionPoint`, represents coordinate (X and Y).
 * `MUKGeometricDimensionWidth`, represents width.
 * `MUKGeometricDimensionHeight`, represents height.
 * `MUKGeometricDimensionSize`, represents size (width and height).
 * `MUKGeometricDimensionRect`, represents rectangle (coordinate and size).
 
 */
typedef enum {
    MUKGeometricDimensionX      =   1 << 0,
    MUKGeometricDimensionY      =   1 << 1,
    MUKGeometricDimensionPoint  =   (MUKGeometricDimensionX|MUKGeometricDimensionY),
    
    MUKGeometricDimensionWidth  =   1 << 2,
    MUKGeometricDimensionHeight =   1 << 3,
    MUKGeometricDimensionSize   =   (MUKGeometricDimensionWidth|MUKGeometricDimensionHeight),
    
    MUKGeometricDimensionRect   = (MUKGeometricDimensionPoint|MUKGeometricDimensionSize)
} MUKGeometricDimension;

@interface MUK (Geometry)
/**
 Rounds a float value for geometric representation.
 @param value Value to round.
 @return Result of `roundf()` to `value`, or `0.0` if `value` is *NaN*.
 */
+ (CGFloat)geometricRoundingOfValue:(CGFloat)value;
/**
 Rounds a point for geometric representation.
 @param point Point to round.
 @param dimensions A bitmask of dimensions to round.
 @return Rounded point.
 @see geometricRoundingOfValue:
 */ 
+ (CGPoint)point:(CGPoint)point geometricRoundingOfDimensions:(MUKGeometricDimension)dimensions;
/**
 Rounds a size for geometric representation.
 @param size Size to round.
 @param dimensions A bitmask of dimensions to round.
 @return Rounded size.
 @see geometricRoundingOfValue:
 */ 
+ (CGSize)size:(CGSize)size geometricRoundingOfDimensions:(MUKGeometricDimension)dimensions;
/**
 Rounds a rectangle for geometric representation.
 @param rect Rectangle to round.
 @param dimensions A bitmask of dimensions to round.
 @return Rounded rectangle.
 @see geometricRoundingOfValue:
 @see point:geometricRoundingOfDimensions:
 @see size:geometricRoundingOfDimensions:
 */ 
+ (CGRect)rect:(CGRect)rect geometricRoundingOfDimensions:(MUKGeometricDimension)dimensions;

@end
