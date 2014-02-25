// Copyright (c) 2014, Marco Muccinelli
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


#import <SenTestingKit/SenTestingKit.h>
#import "MUK+Image.h"

@interface MUKToolkitImageTests : SenTestCase
- (UIImage *)newImageOfSize:(CGSize)size;
@end

@implementation MUKToolkitImageTests

- (void)testColorsExistence {
    UIColor *color = [MUK imageBlurDarkEffectTintColor];
    STAssertNotNil(color, @"Dark effect tint color exists");
    
    color = [MUK imageBlurExtraLightEffectTintColor];
    STAssertNotNil(color, @"Extra light effect tint color exists");
    
    color = [MUK imageBlurLightEffectTintColor];
    STAssertNotNil(color, @"Light effect tint color exists");
}

- (void)testImageBlur {
    UIImage *image = nil;
    STAssertNoThrow([MUK image:image applyingBlurWithRadius:-1.0f iterationsCount:-1 tintColor:nil saturationDeltaFactor:-1.0f maskImage:nil], @"Negative values do not cause exception");
    
    image = [self newImageOfSize:CGSizeMake(200.0f, 200.0f)];
    STAssertNoThrow([MUK image:image applyingBlurWithRadius:-1.0f iterationsCount:-1 tintColor:nil saturationDeltaFactor:-1.0f maskImage:nil], @"Negative values do not cause exception");
    
    UIImage *blurredImage = [MUK image:image applyingBlurWithRadius:-1.0f iterationsCount:-1 tintColor:nil saturationDeltaFactor:-1.0f maskImage:nil];
    STAssertNotNil(blurredImage, @"An image always gives a blurred image");
    STAssertTrue(CGSizeEqualToSize(image.size, blurredImage.size), @"Image sizes match");
    
    blurredImage = [MUK image:image applyingBlurWithRadius:MUKImageBlurDarkEffectBlurRadius iterationsCount:MUKImageBlurDefaultIterationsCount tintColor:[MUK imageBlurDarkEffectTintColor] saturationDeltaFactor:MUKImageBlurDefaultSaturationDeltaFactor maskImage:nil];
    STAssertNotNil(blurredImage, @"An image always gives a blurred image");
    STAssertTrue(CGSizeEqualToSize(image.size, blurredImage.size), @"Image sizes match");
}

#pragma mark - Private

- (UIImage *)newImageOfSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
