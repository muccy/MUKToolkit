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

#import "MUKToolkitURLTests.h"
#import "MUK+URL.h"

@implementation MUKToolkitURLTests

- (void)testImageURLs {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSURL *imageURL = [MUK URLForImageFileWithName:@"arrow" extension:@"png" bundle:bundle highResolution:NO];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[imageURL path]];
    STAssertNotNil(image, @"Image exists");
    
    imageURL = [MUK URLForImageFileWithName:@"arrow.png" extension:nil bundle:bundle highResolution:NO];
    image = [[UIImage alloc] initWithContentsOfFile:[imageURL path]];
    STAssertNotNil(image, @"Image exists");
    
    imageURL = [MUK URLForImageFileWithName:@"arrow" extension:@"png" bundle:bundle highResolution:YES];
    image = [[UIImage alloc] initWithContentsOfFile:[imageURL path]];
    STAssertTrue([[imageURL path] rangeOfString:@"@2x"].location != NSNotFound, @"Image is hi res");
    STAssertNotNil(image, @"Image exists");
    
    imageURL = [MUK URLForImageFileWithName:@"arrow.png" extension:nil bundle:bundle highResolution:YES];
    image = [[UIImage alloc] initWithContentsOfFile:[imageURL path]];
    STAssertTrue([[imageURL path] rangeOfString:@"@2x"].location != NSNotFound, @"Image is hi res");
    STAssertNotNil(image, @"Image exists");
    
    imageURL = [MUK URLForImageFileWithName:@"arrow" extension:@"jpg" bundle:bundle highResolution:NO];
    image = [[UIImage alloc] initWithContentsOfFile:[imageURL path]];
    STAssertNil(image, @"Image does not exist");
    
    imageURL = [MUK URLForImageFileWithName:@"gnegne.jpg" extension:nil bundle:bundle highResolution:NO];
    image = [[UIImage alloc] initWithContentsOfFile:[imageURL path]];
    STAssertNil(image, @"Image does not exist");
    
    imageURL = [MUK URLForImageFileWithName:@"arrows" extension:@"png" bundle:bundle highResolution:NO];
    image = [[UIImage alloc] initWithContentsOfFile:[imageURL path]];
    STAssertNotNil(image, @"Image exist");
    
    imageURL = [MUK URLForImageFileWithName:@"arrows" extension:@"png" bundle:bundle highResolution:YES];
    image = [[UIImage alloc] initWithContentsOfFile:[imageURL path]];
    STAssertTrue([[imageURL path] rangeOfString:@"@2x"].location == NSNotFound, @"Image does not exist at high resolution");
    STAssertNotNil(image, @"Image does not exist at high resolution, but is returned at @1x");
}

@end
