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

#import "MUKToolkitGeometryTests.h"
#import "MUK+Geometry.h"

@interface MUKToolkitGeometryTests ()
- (CGPoint)centerOfRect_:(CGRect)rect;
@end

@implementation MUKToolkitGeometryTests

- (void)testValueRounding {    
    CGFloat value = 1.2, expectedValue = 1.0;
    CGFloat roundedValue = [MUK geometricRoundingOfValue:value];
    STAssertEqualsWithAccuracy(roundedValue, expectedValue, 0.001, @"Expected value should match");
    
    value = NAN, expectedValue = 0.0;
    roundedValue = [MUK geometricRoundingOfValue:value];
    STAssertEqualsWithAccuracy(roundedValue, expectedValue, 0.001, @"NaN should be converted to 0.0");
}

- (void)testPointRounding {
    CGPoint point = CGPointMake(NAN, 1.2);
    CGPoint roundedPoint = [MUK point:point geometricRoundingOfDimensions:MUKGeometricDimensionX];
    STAssertEqualsWithAccuracy((CGFloat)0.0, roundedPoint.x, 0.001, @"x=NaN should be converted to 0.0");
    STAssertEqualsWithAccuracy(point.y, roundedPoint.y, 0.001, @"y untouched");
    
    roundedPoint = [MUK point:point geometricRoundingOfDimensions:MUKGeometricDimensionY];
    STAssertTrue(isnan(roundedPoint.x), @"x untouched");
    STAssertEqualsWithAccuracy((CGFloat)1.0, roundedPoint.y, 0.001, @"y should be rounded");
    
    roundedPoint = [MUK point:point geometricRoundingOfDimensions:MUKGeometricDimensionPoint];
    STAssertEqualsWithAccuracy((CGFloat)0.0, roundedPoint.x, 0.001, @"x=NaN should be converted to 0.0");
    STAssertEqualsWithAccuracy((CGFloat)1.0, roundedPoint.y, 0.001, @"y should be rounded");
}

- (void)testSizeRounding {
    CGSize size = CGSizeMake(NAN, 1.2);
    CGSize roundedSize = [MUK size:size geometricRoundingOfDimensions:MUKGeometricDimensionWidth];
    STAssertEqualsWithAccuracy((CGFloat)0.0, roundedSize.width, 0.001, @"width=NaN should be converted to 0.0");
    STAssertEqualsWithAccuracy(size.height, roundedSize.height, 0.001, @"height untouched");
    
    roundedSize = [MUK size:size geometricRoundingOfDimensions:MUKGeometricDimensionHeight];
    STAssertTrue(isnan(roundedSize.width), @"width untouched");
    STAssertEqualsWithAccuracy((CGFloat)1.0, roundedSize.height, 0.001, @"height should be rounded");
    
    roundedSize = [MUK size:size geometricRoundingOfDimensions:MUKGeometricDimensionSize];
    STAssertEqualsWithAccuracy((CGFloat)0.0, roundedSize.width, 0.001, @"width=NaN should be converted to 0.0");
    STAssertEqualsWithAccuracy((CGFloat)1.0, roundedSize.height, 0.001, @"height should be rounded");
}

- (void)testRectRounding {
    CGRect rect = CGRectMake(NAN, 1.2, NAN, 1.7);
    
    CGRect expectedRect = CGRectMake(0.0, 1.0, 0.0, 2.0);
    CGRect roundedRect = [MUK rect:rect geometricRoundingOfDimensions:MUKGeometricDimensionRect];
    STAssertTrue(CGRectEqualToRect(roundedRect, expectedRect), @"Every rounding should be applied");
    
    expectedRect = CGRectMake(0.0, 1.0, 0.0, 1.7);
    roundedRect = [MUK rect:rect geometricRoundingOfDimensions:(MUKGeometricDimensionX|MUKGeometricDimensionY|MUKGeometricDimensionWidth)];
    STAssertTrue(CGRectEqualToRect(roundedRect, expectedRect), @"Only height rounding not applied");
}

- (void)testTransformIdentity {
    CGRect rect = CGRectMake(10, 10, 200, 200);
    CGRect baseRect = CGRectMake(0, 0, 200, 100);
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformIdentity respectToRect:baseRect];
    STAssertTrue(CGRectEqualToRect(rect, transformedRect), @"Should be the same of the original rect");
}

- (void)testTransformScaleToFill {
    CGRect rect = CGRectMake(10, 10, 200, 200);
    CGRect baseRect = CGRectMake(0, 0, 200, 100);
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformScaleToFill respectToRect:baseRect];
    STAssertTrue(CGRectEqualToRect(baseRect, transformedRect), @"Should be the same of the base rect");
}

- (void)testTransformAspectFit {
    // Ratio = 1
    CGRect rect = CGRectMake(10, 10, 200, 200);
    float aspectRatio = rect.size.width/rect.size.height;
    CGRect baseRect = CGRectMake(100, 100, 57, 39);
    
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformScaleAspectFit respectToRect:baseRect];
    float transformedAspectRatio = transformedRect.size.width/transformedRect.size.height;
    STAssertEqualsWithAccuracy(aspectRatio, transformedAspectRatio, 0.000001, @"Aspect ratio unchanged");
    STAssertTrue(CGRectContainsRect(baseRect, transformedRect), @"Fitted rect should be inside base rect");
    STAssertTrue(CGPointEqualToPoint([self centerOfRect_:transformedRect], [self centerOfRect_:baseRect]), @"Centers must be the same");
    
    // Ratio > 1
    rect = CGRectMake(10, 10, 301, 201);
    aspectRatio = rect.size.width/rect.size.height;
    
    transformedRect = [MUK rect:rect transform:MUKGeometryTransformScaleAspectFit respectToRect:baseRect];
    transformedAspectRatio = transformedRect.size.width/transformedRect.size.height;
    STAssertEqualsWithAccuracy(aspectRatio, transformedAspectRatio, 0.000001, @"Aspect ratio unchanged");
    STAssertTrue(CGRectContainsRect(baseRect, transformedRect), @"Fitted rect should be inside base rect");
    STAssertTrue(CGPointEqualToPoint([self centerOfRect_:transformedRect], [self centerOfRect_:baseRect]), @"Centers must be the same");
    
    // Ratio < 1
    rect = CGRectMake(10, 10, 11, 201);
    aspectRatio = rect.size.width/rect.size.height;
    
    transformedRect = [MUK rect:rect transform:MUKGeometryTransformScaleAspectFit respectToRect:baseRect];
    transformedAspectRatio = transformedRect.size.width/transformedRect.size.height;
    STAssertEqualsWithAccuracy(aspectRatio, transformedAspectRatio, 0.000001, @"Aspect ratio unchanged");
    STAssertTrue(CGRectContainsRect(baseRect, transformedRect), @"Fitted rect should be inside base rect");
    STAssertTrue(CGPointEqualToPoint([self centerOfRect_:transformedRect], [self centerOfRect_:baseRect]), @"Centers must be the same");
}

- (void)testTransformAspectFill {
    // Ratio = 1
    CGRect rect = CGRectMake(10, 10, 200, 200);
    float aspectRatio = rect.size.width/rect.size.height;
    CGRect baseRect = CGRectMake(100, 100, 57, 39);
    
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformScaleAspectFill respectToRect:baseRect];
    float transformedAspectRatio = transformedRect.size.width/transformedRect.size.height;
    STAssertEqualsWithAccuracy(aspectRatio, transformedAspectRatio, 0.000001, @"Aspect ratio unchanged");
    STAssertTrue(CGRectContainsRect(transformedRect, baseRect), @"Base rect should be inside transformed rect");
    STAssertTrue(CGPointEqualToPoint([self centerOfRect_:transformedRect], [self centerOfRect_:baseRect]), @"Centers must be the same");
    
    // Ratio > 1
    rect = CGRectMake(10, 10, 301, 201);
    aspectRatio = rect.size.width/rect.size.height;
    
    transformedRect = [MUK rect:rect transform:MUKGeometryTransformScaleAspectFill respectToRect:baseRect];
    transformedAspectRatio = transformedRect.size.width/transformedRect.size.height;
    STAssertEqualsWithAccuracy(aspectRatio, transformedAspectRatio, 0.000001, @"Aspect ratio unchanged");
    STAssertTrue(CGRectContainsRect(transformedRect, baseRect), @"Base rect should be inside transformed rect");
    STAssertTrue(CGPointEqualToPoint([self centerOfRect_:transformedRect], [self centerOfRect_:baseRect]), @"Centers must be the same");
    
    // Ratio < 1
    rect = CGRectMake(10, 10, 11, 201);
    aspectRatio = rect.size.width/rect.size.height;
    
    transformedRect = [MUK rect:rect transform:MUKGeometryTransformScaleAspectFill respectToRect:baseRect];
    transformedAspectRatio = transformedRect.size.width/transformedRect.size.height;
    STAssertEqualsWithAccuracy(aspectRatio, transformedAspectRatio, 0.000001, @"Aspect ratio unchanged");
    STAssertTrue(CGRectContainsRect(transformedRect, baseRect), @"Base rect should be inside transformed rect");
    STAssertTrue(CGPointEqualToPoint([self centerOfRect_:transformedRect], [self centerOfRect_:baseRect]), @"Centers must be the same");
}

- (void)testTransformCenter {
    CGRect rect = CGRectMake(11, 9, 211, 151);
    CGRect baseRect = CGRectMake(107, 89, 201, 101);
    
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformCenter respectToRect:baseRect];
    STAssertTrue(CGSizeEqualToSize(transformedRect.size, rect.size), @"Size unchanged");
    STAssertTrue(CGPointEqualToPoint([self centerOfRect_:transformedRect], [self centerOfRect_:baseRect]), @"Centers must be the same");
}

- (void)testTransformTop {
    CGRect rect = CGRectMake(11, 9, 211, 151);
    CGRect baseRect = CGRectMake(107, 89, 201, 101);
    
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformTop respectToRect:baseRect];
    STAssertTrue(CGSizeEqualToSize(transformedRect.size, rect.size), @"Size unchanged");
    STAssertEqualsWithAccuracy(transformedRect.origin.y, baseRect.origin.y, 0.000000001, @"Stays at top");
    STAssertEqualsWithAccuracy(CGRectGetMidX(transformedRect), CGRectGetMidX(baseRect), 0.00000001, @"Stays in the middle");
}

- (void)testTransformBottom {
    CGRect rect = CGRectMake(11, 9, 211, 151);
    CGRect baseRect = CGRectMake(107, 89, 201, 101);
    
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformBottom respectToRect:baseRect];
    STAssertTrue(CGSizeEqualToSize(transformedRect.size, rect.size), @"Size unchanged");
    STAssertEqualsWithAccuracy(CGRectGetMaxY(transformedRect), CGRectGetMaxY(baseRect), 0.000000001, @"Stays at bottom");
    STAssertEqualsWithAccuracy(CGRectGetMidX(transformedRect), CGRectGetMidX(baseRect), 0.00000001, @"Stays in the middle");
}

- (void)testTransformLeft {
    CGRect rect = CGRectMake(11, 9, 211, 151);
    CGRect baseRect = CGRectMake(107, 89, 201, 101);
    
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformLeft respectToRect:baseRect];
    STAssertTrue(CGSizeEqualToSize(transformedRect.size, rect.size), @"Size unchanged");
    STAssertEqualsWithAccuracy(transformedRect.origin.x, baseRect.origin.x, 0.000000001, @"Stays at left");
    STAssertEqualsWithAccuracy(CGRectGetMidY(transformedRect), CGRectGetMidY(baseRect), 0.00000001, @"Stays in the middle");
}

- (void)testTransformRight {
    CGRect rect = CGRectMake(11, 9, 211, 151);
    CGRect baseRect = CGRectMake(107, 89, 201, 101);
    
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformRight respectToRect:baseRect];
    STAssertTrue(CGSizeEqualToSize(transformedRect.size, rect.size), @"Size unchanged");
    STAssertEqualsWithAccuracy(CGRectGetMaxX(transformedRect), CGRectGetMaxX(baseRect), 0.000000001, @"Stays at right");
    STAssertEqualsWithAccuracy(CGRectGetMidY(transformedRect), CGRectGetMidY(baseRect), 0.00000001, @"Stays in the middle");
}

- (void)testTransformTopLeft {
    CGRect rect = CGRectMake(11, 9, 211, 151);
    CGRect baseRect = CGRectMake(107, 89, 201, 101);
    
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformTopLeft respectToRect:baseRect];
    STAssertTrue(CGSizeEqualToSize(transformedRect.size, rect.size), @"Size unchanged");
    STAssertEqualsWithAccuracy(transformedRect.origin.x, baseRect.origin.x, 0.000000001, @"Stays at left");
    STAssertEqualsWithAccuracy(transformedRect.origin.y, baseRect.origin.y, 0.00000001, @"Stays at top");
}

- (void)testTransformTopRight {
    CGRect rect = CGRectMake(11, 9, 211, 151);
    CGRect baseRect = CGRectMake(107, 89, 201, 101);
    
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformTopRight respectToRect:baseRect];
    STAssertTrue(CGSizeEqualToSize(transformedRect.size, rect.size), @"Size unchanged");
    STAssertEqualsWithAccuracy(CGRectGetMaxX(transformedRect), CGRectGetMaxX(baseRect), 0.000000001, @"Stays at right");
    STAssertEqualsWithAccuracy(transformedRect.origin.y, baseRect.origin.y, 0.00000001, @"Stays at top");
}

- (void)testTransforBottomLeft {
    CGRect rect = CGRectMake(11, 9, 211, 151);
    CGRect baseRect = CGRectMake(107, 89, 201, 101);
    
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformBottomLeft respectToRect:baseRect];
    STAssertTrue(CGSizeEqualToSize(transformedRect.size, rect.size), @"Size unchanged");
    STAssertEqualsWithAccuracy(transformedRect.origin.x, baseRect.origin.x, 0.000000001, @"Stays at left");
    STAssertEqualsWithAccuracy(CGRectGetMaxY(transformedRect), CGRectGetMaxY(baseRect), 0.000000001, @"Stays at bottom");
}

- (void)testTransformBottomRight {
    CGRect rect = CGRectMake(11, 9, 211, 151);
    CGRect baseRect = CGRectMake(107, 89, 201, 101);
    
    CGRect transformedRect = [MUK rect:rect transform:MUKGeometryTransformBottomRight respectToRect:baseRect];
    STAssertTrue(CGSizeEqualToSize(transformedRect.size, rect.size), @"Size unchanged");
    STAssertEqualsWithAccuracy(CGRectGetMaxX(transformedRect), CGRectGetMaxX(baseRect), 0.000000001, @"Stays at right");
    STAssertEqualsWithAccuracy(CGRectGetMaxY(transformedRect), CGRectGetMaxY(baseRect), 0.000000001, @"Stays at bottom");
}

#pragma mark - Private

- (CGPoint)centerOfRect_:(CGRect)rect {
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    return center;
}

@end
