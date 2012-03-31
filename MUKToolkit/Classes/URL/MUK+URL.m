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

#import "MUK+URL.h"
#import <UIKit/UIKit.h>

@implementation MUK (URL)

+ (NSURL *)URLForDocumentsDirectory {
    return [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
}

+ (NSURL *)URLForCachesDirectory {
    return [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
}

+ (NSURL *)URLForTemporaryDirectory {
    NSString *path = NSTemporaryDirectory();
    if (path) {
        return [NSURL fileURLWithPath:path];
    }
    
    return nil;
}

+ (NSURL *)URLForImageFileWithName:(NSString *)name extension:(NSString *)extension bundle:(NSBundle *)bundle highResolution:(BOOL)hiRes
{
    bundle = bundle ?: [NSBundle mainBundle];
    
    if (!extension) {
        // Calculate name and extension
        extension = [name pathExtension];
        if ([extension length] == 0) extension = @"png";
        
        name = [name stringByDeletingPathExtension];
    }
    
    NSString *hiResName = nil;
    if (hiRes) {
        // Try to find high resolution image
        hiResName = [name stringByAppendingString:@"@2x"];
    }
    
    NSURL *fileURL = nil;
    if (hiResName) {
        // Search URL for high resolution
        fileURL = [bundle URLForResource:hiResName withExtension:extension];
    }
    
    if (fileURL == nil) {
        // If no high resolution required or no high resolution found search
        // for regular files
        fileURL = [bundle URLForResource:name withExtension:extension]; 
    }
    
    return fileURL;
}

+ (NSURL *)URLForImageFileNamed:(NSString *)name bundle:(NSBundle *)bundle {
    BOOL hiRes = ([[UIScreen mainScreen] scale] > 1.1);
    return [self URLForImageFileWithName:name extension:nil bundle:bundle highResolution:hiRes];
}

@end
