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

#import "MUK.h"

extern CGFloat const MUKImageBlurExtraLightEffectBlurRadius;
extern CGFloat const MUKImageBlurLightEffectBlurRadius;
extern CGFloat const MUKImageBlurDarkEffectBlurRadius;
extern CGFloat const MUKImageBlurDefaultBlurRadius;
extern NSInteger const MUKImageBlurDefaultIterationsCount;
extern CGFloat const MUKImageBlurSuggestedTintColorAlpha;
extern CGFloat const MUKImageBlurDefaultSaturationDeltaFactor;

/**
 Methods involving images.
 */
@interface MUK (Image)
/**
 Create a blurred image, as seen in popular category `UIImage+ImageEffects`,
 explained during Apple WWDC 2013 session titled 'Implementing Engaging UI on iOS'.
 
 @param sourceImage Image which will be blurred. If image width or height is less
 than 1.0, the image is null or it is not backed by a CGImage, this method will
 return `nil`.
 @param blurRadius Blur radius. Use `MUKImageBlurDefaultBlurRadius`, 
 `MUKImageBlurExtraLightEffectBlurRadius`,
 `MUKImageBlurLightEffectBlurRadius`,
 `MUKImageBlurDarkEffectBlurRadius` as standard presets.
 @param iterationsCount How many passes should sourceImage to receive. Use
 `MUKImageBlurDefaultIterationsCount` as preset.
 @param tintColor The color the blur should assume. Use +imageBlurLightEffectTintColor,
 +imageBlurExtraLightEffectTintColor, +imageBlurDarkEffectTintColor as standard
 presets.
 @param saturationDeltaFactor How much image colors should be saturated. Use 
 `MUKImageBlurDefaultSaturationDeltaFactor` as a valid preset. Pass a negative
 value not to saturate image.
 @param maskImage Blurred image could be clipped inside a clipping mask. Pass `nil`
 is order to blur the entire image.
 
 @return Blurred image.
 */
+ (UIImage *)image:(UIImage *)sourceImage applyingBlurWithRadius:(CGFloat)blurRadius iterationsCount:(NSInteger)iterationsCount tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

/**
 Image blur light effect tint color.
 
 @return The color to be used with +image:applyingBlurWithRadius:iterationsCount:tintColor:saturationDeltaFactor:maskImage:
 to achieve blur light effect.
 */
+ (UIColor *)imageBlurLightEffectTintColor;

/**
 Image blur extra light effect tint color.
 
 @return The color to be used with +image:applyingBlurWithRadius:iterationsCount:tintColor:saturationDeltaFactor:maskImage:
 to achieve blur extra light effect.
 */
+ (UIColor *)imageBlurExtraLightEffectTintColor;

/**
 Image blur dark effect tint color.
 
 @return The color to be used with +image:applyingBlurWithRadius:iterationsCount:tintColor:saturationDeltaFactor:maskImage:
 to achieve blur dark effect.
 */
+ (UIColor *)imageBlurDarkEffectTintColor;
@end
