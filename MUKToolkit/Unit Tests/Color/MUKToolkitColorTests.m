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

#import "MUKToolkitColorTests.h"
#import "MUK+Color.h"

@implementation MUKToolkitColorTests

- (void)test8BitRGBA {
    NSUInteger red = 255;
    NSUInteger green = 156;
    NSUInteger blue = 125;
    CGFloat alpha = 0.56;
    UIColor *color = [MUK colorWith8BitRGBAComponents:red, green, blue, alpha];
    
    CGFloat detectedRed, detectedGreen, detectedBlue, detectedAlpha;
    [color getRed:&detectedRed green:&detectedGreen blue:&detectedBlue alpha:&detectedAlpha];
    
    STAssertEqualsWithAccuracy((CGFloat)red, detectedRed*255.0f, 0.001f, nil);
    STAssertEqualsWithAccuracy((CGFloat)green, detectedGreen*255.0f, 0.001f, nil);
    STAssertEqualsWithAccuracy((CGFloat)blue, detectedBlue*255.0f, 0.001f, nil);
    STAssertEqualsWithAccuracy(alpha, detectedAlpha, 0.001f, nil);
}

- (void)testHexString {
    STAssertNoThrow([MUK colorWithHexadecimalString:nil], @"Never throw exceptions");
    STAssertNoThrow([MUK colorWithHexadecimalString:@"#FF"], @"Never throw exceptions");
    
    UIColor *color = [MUK colorWithHexadecimalString:nil];
    CGFloat detectedRed, detectedGreen, detectedBlue, detectedAlpha;
    [color getRed:&detectedRed green:&detectedGreen blue:&detectedBlue alpha:&detectedAlpha];
    STAssertEqualsWithAccuracy((CGFloat)0.0f, detectedAlpha, 0.0001f, @"nil leads to transparent color");
    
    color = [MUK colorWithHexadecimalString:@"#ff0000"];
    STAssertEqualObjects(color, [UIColor redColor], @"Red color");
    
    UIColor *color2 = [MUK colorWithHexadecimalString:@"#FF0000"];
    STAssertEqualObjects(color, color2, @"Case insensitive");
    
    color2 = [MUK colorWithHexadecimalString:@"0xFF0000"];
    STAssertEqualObjects(color, color2, @"Prefix could be 0x");
    
    color2 = [MUK colorWithHexadecimalString:@"FF0000"];
    STAssertEqualObjects(color, color2, @"Prefix could be skipped");
    
    color2 = [MUK colorWithHexadecimalString:@"f00"];
    STAssertEqualObjects(color, color2, @"CSS contract form is allowed");
    
    color2 = [MUK colorWithHexadecimalString:@"#FF0000FF"];
    STAssertEqualObjects(color, color2, @"Alpha is 100% by default");
    
    color2 = [MUK colorWithHexadecimalString:@"#FF"];
    STAssertNil(color2, @"Malformed hex strings lead to nil colors");
}

- (void)testColorHSBATrasformation {
    // Warning: setting values to 0.0f may lead to false negatives, because (for
    // example) when S=0, H doesn't change final color, so -getHue:saturation:brightness:alpha:
    // will always return H=0
    
    CGFloat const originalHue = 0.4f;
    CGFloat const transformedHue = 0.55f;
    
    CGFloat const originalSaturation = 1.0f;
    CGFloat const transformedSaturation = 0.1f;
    
    CGFloat const originalBrightness = 1.0f;
    CGFloat const transformedBrightness = 0.12f;
    
    CGFloat const originalAlpha = 1.0f;
    CGFloat const transformedAlpha = originalAlpha;
    
    UIColor *originalColor = [UIColor colorWithHue:originalHue saturation:originalSaturation brightness:originalBrightness alpha:originalAlpha];
    
    UIColor *trasformedColor = [MUK color:originalColor withTransformation:^UIColor *(CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha)
    {
        STAssertEqualsWithAccuracy(originalHue, hue, 0.0001f, nil);
        STAssertEqualsWithAccuracy(originalSaturation, saturation, 0.0001f, nil);
        STAssertEqualsWithAccuracy(originalBrightness, brightness, 0.0001f, nil);
        STAssertEqualsWithAccuracy(originalAlpha, alpha, 0.0001f, nil);
        
        return [UIColor colorWithHue:transformedHue saturation:transformedSaturation brightness:transformedBrightness alpha:transformedAlpha];
    }];
    
    CGFloat h, s, b, a;
    [trasformedColor getHue:&h saturation:&s brightness:&b alpha:&a];
    STAssertEqualsWithAccuracy(h, transformedHue, 0.0001f, nil);
    STAssertEqualsWithAccuracy(s, transformedSaturation, 0.0001f, nil);
    STAssertEqualsWithAccuracy(b, transformedBrightness, 0.0001f, nil);
    STAssertEqualsWithAccuracy(a, transformedAlpha, 0.0001f, nil);
}

@end
