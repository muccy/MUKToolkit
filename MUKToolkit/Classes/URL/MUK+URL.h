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
 Methods involving URLs
 */
@interface MUK (URL)
/**
 Shortend to get file URL to *Documents* directory.
 @return File URL to *Documents* directory.
 */
+ (NSURL *)URLForDocumentsDirectory;
/**
 Shortend to get file URL to *Caches* directory.
 @return File URL to *Caches* directory.
 */
+ (NSURL *)URLForCachesDirectory;
/**
 Shortend to get file URL to *Temporary* directory.
 @return File URL to *Temporary* directory.
 */
+ (NSURL *)URLForTemporaryDirectory;
/**
 File URL to an image file.
 
 You can use this method to find images in various bundles.
    NSURL *imageURL = [MUK URLForImageFileWithName:@"panda.png" 
                        extension:nil bundle:aBundle highResolution:YES];
 
 @param name Name of image. If you have an image file called 
 `panda@2x.png`, `name` will be `panda`.
 @param extension Extension of image. If you have an image file called 
 `panda@2x.png`, `extension` will be `png`. If `nil` extension is 
 calculated from `name` and, if `name` does not contain a valid extension,
 `png` is used by default.
 @param bundle Bundle where image is in. If `nil` defaults to 
 `[NSBundle mainBundle]`.
 @param hiRes Say if you want to search for high resolution version of 
 the image: if `YES`, this method searches for `name@2x` image before.
 @return File URL of image.
 */
+ (NSURL *)URLForImageFileWithName:(NSString *)name extension:(NSString *)extension bundle:(NSBundle *)bundle highResolution:(BOOL)hiRes;
/**
 Shortend to URLForImageFileWithName:extension:bundle:highResolution:
 
 This method calls URLForImageFileWithName:extension:bundle:highResolution:
 with `name`=`name`, `extension`=`nil`, `bundle`=`bundle` and
 `highResolution` depending from main screen scale.
 
 @param name Full name of image (e.g. `panda.png`).
 @param bundle Bundle where image is in. If `nil` defaults to 
 `[NSBundle mainBundle]`.
 @return File URL of image.
 @see URLForImageFileWithName:extension:bundle:highResolution:
 */
+ (NSURL *)URLForImageFileNamed:(NSString *)name bundle:(NSBundle *)bundle;

@end
