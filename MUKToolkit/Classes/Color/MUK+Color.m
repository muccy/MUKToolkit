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

#import "MUK+Color.h"

@implementation MUK (Color)

+ (UIColor *)colorWith8BitRGBAComponents:(NSUInteger)firstArg, ... {
    va_list args;
    va_start(args, firstArg);
    
    static NSUInteger const kComponentsCount = 3;
    NSUInteger components[kComponentsCount];
    
    components[0] = firstArg;
    for (NSUInteger i=1; i<kComponentsCount; i++) {
        components[i] = va_arg(args, NSUInteger);
    }
    
    CGFloat alpha = va_arg(args, double);
    va_end(args);
    
    return [UIColor colorWithRed:(CGFloat)components[0]/255.0f green:(CGFloat)components[1]/255.0f blue:(CGFloat)components[2]/255.0f alpha:alpha];
}

+ (UIColor *)colorWithHexadecimalString:(NSString *)hexString {
    // Convert to lowercase
    hexString = [hexString lowercaseString];
    
    // Try hex
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    
    switch ([hexString length]) {
        case 0:
            hexString = @"00000000";
            break;

        case 3: {
            NSString *red = [hexString substringWithRange:NSMakeRange(0, 1)];
            NSString *green = [hexString substringWithRange:NSMakeRange(1, 1)];
            NSString *blue = [hexString substringWithRange:NSMakeRange(2, 1)];
            hexString = [NSString stringWithFormat:@"%1$@%1$@%2$@%2$@%3$@%3$@ff", red, green, blue];
            break;
        }
            
        case 6:
            hexString = [hexString stringByAppendingString:@"ff"];
            break;

        case 8:
            //do nothing
            break;

        default:
            return nil;
    }
    
    // Get RGBA value
    uint32_t rgba;
    NSScanner *scanner = [[NSScanner alloc] initWithString:hexString];
    if (![scanner scanHexInt:&rgba]) {
        return nil;
    }
    
    // Get components
    CGFloat red = ((rgba & 0xFF000000) >> 24) / 255.0f;
    CGFloat green = ((rgba & 0x00FF0000) >> 16) / 255.0f;
	CGFloat blue = ((rgba & 0x0000FF00) >> 8) / 255.0f;
	CGFloat alpha = (rgba & 0x000000FF) / 255.0f;
    
	return [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)color:(UIColor *)color withHSBATransformation:(UIColor *(^)(CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha))transformationBlock
{
    if (!transformationBlock) {
        return color;
    }
    
    CGFloat h, s, b, a;
    if (![color getHue:&h saturation:&s brightness:&b alpha:&a]) {
        h = s = b = a = 0.0f;
    }
    
    return transformationBlock(h, s, b, a);
}

@end
