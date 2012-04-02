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

#import "MUK+Geometry.h"

@implementation MUK (Geometry)

+ (CGFloat)geometricRoundingOfValue:(CGFloat)value {
    if (isnan(value)) {
        return 0.0;
    }
    
    return roundf(value);
}

+ (CGPoint)point:(CGPoint)point geometricRoundingOfDimensions:(MUKGeometricDimension)dimensions
{
    CGPoint roundedPoint = point;
    
    if ([self bitmask:dimensions containsFlag:MUKGeometricDimensionX]) {
        roundedPoint.x = [self geometricRoundingOfValue:point.x];
    }
    
    if ([self bitmask:dimensions containsFlag:MUKGeometricDimensionY]) {
        roundedPoint.y = [self geometricRoundingOfValue:point.y];
    }
    
    return roundedPoint;
}

+ (CGSize)size:(CGSize)size geometricRoundingOfDimensions:(MUKGeometricDimension)dimensions 
{
    CGSize roundedSize = size;
    
    if ([self bitmask:dimensions containsFlag:MUKGeometricDimensionWidth]) {
        roundedSize.width = [self geometricRoundingOfValue:size.width];
    }
    
    if ([self bitmask:dimensions containsFlag:MUKGeometricDimensionHeight]) {
        roundedSize.height = [self geometricRoundingOfValue:size.height];
    }
    
    return roundedSize;
}

+ (CGRect)rect:(CGRect)rect geometricRoundingOfDimensions:(MUKGeometricDimension)dimensions
{
    CGRect roundedRect = rect;
    
    roundedRect.origin = [self point:rect.origin geometricRoundingOfDimensions:dimensions];
    roundedRect.size = [self size:rect.size geometricRoundingOfDimensions:dimensions];
    
    return roundedRect;
}

+ (CGRect)rect:(CGRect)rect transform:(MUKGeometryTransform)transform respectToRect:(CGRect)baseRect
{
    CGRect transformedRect = rect;
    
    switch (transform) {
        case MUKGeometryTransformScaleToFill: {
            transformedRect = baseRect;
            break;
        }
            
        case MUKGeometryTransformScaleAspectFit: {
            float originalAspectRatio = rect.size.width / rect.size.height;
            float containerAspectRatio = baseRect.size.width / baseRect.size.height;
            
            CGRect scaledRect = rect;
            if (originalAspectRatio > containerAspectRatio) {
                // Scale by width
                scaledRect.size.width = baseRect.size.width;
                scaledRect.size.height = scaledRect.size.width * (1.0/originalAspectRatio);
            } 
            else {
                // Scale by height
                scaledRect.size.height = baseRect.size.height;
                scaledRect.size.width = scaledRect.size.height * originalAspectRatio;
            }
            
            transformedRect = [MUK rect:scaledRect transform:MUKGeometryTransformCenter respectToRect:baseRect];
            break;
        }
            
        case MUKGeometryTransformScaleAspectFill: {
            float originalAspectRatio = rect.size.width / rect.size.height;
            float containerAspectRatio = baseRect.size.width / baseRect.size.height;
            
            CGRect scaledRect = rect;
            if (originalAspectRatio > containerAspectRatio) {
                // Scale by height
                scaledRect.size.height = baseRect.size.height;
                scaledRect.size.width = scaledRect.size.height * originalAspectRatio;
            } 
            else {
                // Scale by width
                scaledRect.size.width = baseRect.size.width;
                scaledRect.size.height = scaledRect.size.width * (1.0/originalAspectRatio);
            }
            
            transformedRect = [MUK rect:scaledRect transform:MUKGeometryTransformCenter respectToRect:baseRect];
            break;
        }
            
        case MUKGeometryTransformCenter: {
            transformedRect.origin.x = (baseRect.size.width - rect.size.width)/2.0 + baseRect.origin.x;
            transformedRect.origin.y = (baseRect.size.height - rect.size.height)/2.0 + baseRect.origin.y;
            
            break;
        }
            
        case MUKGeometryTransformTop: {
            transformedRect.origin.x = (baseRect.size.width - rect.size.width)/2.0 + baseRect.origin.x;
            transformedRect.origin.y = baseRect.origin.y;
            
            break;
        }
            
        case MUKGeometryTransformBottom: {
            transformedRect.origin.x = (baseRect.size.width - rect.size.width)/2.0 + baseRect.origin.x;
            transformedRect.origin.y = baseRect.origin.y - (rect.size.height - baseRect.size.height);
            
            break;
        }
            
        case MUKGeometryTransformLeft: {
            transformedRect.origin.x = baseRect.origin.x;
            transformedRect.origin.y = (baseRect.size.height - rect.size.height)/2.0 + baseRect.origin.y;
            
            break;
        }
            
        case MUKGeometryTransformRight: {
            transformedRect.origin.x = baseRect.origin.x - (rect.size.width - baseRect.size.width);
            transformedRect.origin.y = (baseRect.size.height - rect.size.height)/2.0 + baseRect.origin.y;
            
            break;
        }
            
        case MUKGeometryTransformTopLeft: {
            transformedRect.origin.x = baseRect.origin.x;
            transformedRect.origin.y = baseRect.origin.y;
            
            break;
        }
            
        case MUKGeometryTransformTopRight: {
            transformedRect.origin.x = baseRect.origin.x - (rect.size.width - baseRect.size.width);
            transformedRect.origin.y = baseRect.origin.y;
            
            break;
        }
            
        case MUKGeometryTransformBottomLeft: {
            transformedRect.origin.x = baseRect.origin.x;
            transformedRect.origin.y = baseRect.origin.y - (rect.size.height - baseRect.size.height);
            
            break;
        }
            
        case MUKGeometryTransformBottomRight: {
            transformedRect.origin.x = baseRect.origin.x - (rect.size.width - baseRect.size.width);
            transformedRect.origin.y = baseRect.origin.y - (rect.size.height - baseRect.size.height);
            
            break;
        }
    
        default:
            break;
    }
    
    return transformedRect;
}

@end
