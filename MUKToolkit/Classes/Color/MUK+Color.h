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
 Methods involving colors.
 */
@interface MUK (Color)
/**
 Creates a color by its 8-bit RGB components.
 
 ** Example **
 
 	UIColor *color = [MUK colorWith8BitRGBAComponents:255, 0, 0, 1.0]; // Red
 
 @param component First component in 0-255 range, which represents red.
 @param ... List of 2 remaining components in 0-255 range, plus last `double` 
 alpha value. 
 If first component is red, here you specify second one – green – and third one – blue.
 Last value is alpha (0.0-1.0).
 @return An initialized color.
 */
+ (UIColor *)colorWith8BitRGBAComponents:(NSUInteger)component, ...;

/**
 Creates a color with a hex string.
 This method implementation is profoundly derived from great UIColor category
 at this page: https://github.com/nicklockwood/ColorUtils
 
 ** Examples **
 
    UIColor *color = [MUK colorWithHexadecimalString:@"#ff0000"]; // red
    color = [MUK colorWithHexadecimalString:@"0xff0000"]; // red
    color = [MUK colorWithHexadecimalString:@"ff0000"]; // red
    color = [MUK colorWithHexadecimalString:@"#ff0000ff"]; // red
    color = [MUK colorWithHexadecimalString:@"#f00"]; // red
 
 @param hexString Hexadecimal string to convert.
 @return An initialized color or `nil` if hexString is not correctly formed.
 */
+ (UIColor *)colorWithHexadecimalString:(NSString *)hexString;

/**
 Creates a color trasforming a given one in HSBA space.
 
 @param sourceColor The source color.
 @param transformationBlock A block which takes original HSBA values (or zeros
 if values could not be extracted) and returns the modified color.
 @return The color returned by transformationBlock or original sourceColor if
 no transformationBlock is passed.
 */
+ (UIColor *)color:(UIColor *)sourceColor withHSBATransformation:(UIColor *(^)(CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha))transformationBlock;

@end
