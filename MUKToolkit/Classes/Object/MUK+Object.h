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
 Generic methods for object level.
 */
@interface MUK (Object)

/**
 Instantiate an object from a NIB file.
 
 This method could be very useful in order to load views. Say you developed a
 `UIView` subclass called `MyView`: you can design your view into Interface Builder
 (in `MyView.xib`) and, then, you load view using:
    MyView *myView = [MUK objectOfClass:[MyView class] instantiatedFromNibNamed:nil
                                 bundle:nil owner:nil options:nil passingTest:nil];
 
 @param objectClassOrNil Class object to instantiate. If you specify it, then `nibNameOrNil`
 could be calculated at runtime and returned object is type checked. You could also
 leave this parameter `nil` but, in that case, you have to specify `nibNameOrNil`.
 @param nibNameOrNil Name of NIB file containing object to be instantiated. You could
 leave this parameter `nil` and it will default to the name of `objectClassOrNil`.
 @param bundleOrNil Bundle containing NIB file. If `nil` it defaults to `[NSBundle mainBundle]`.
 @param owner Owner object which will be used during instantiation. It could be 
 `nil` if you do not need it.
 @param options Options dictionary used during instantiation. Not required; see
 `UINib` for details.
 @param predicate Block which test objects that are member of class given with
 `objectClassOrNil`. If no class is specified, every object unarchived from NIB will
 be passed to this block. This block takes two parameters: the object to inspect
 and the index of this object.
 @warning Instantiated object indexes may not reflect the position given in
 Interface Builder. See: http://stackoverflow.com/a/14220815/224629 .
 @return Instantiated object. It could return `nil` if bundle could not be found,
 if object could not be instantiated, if predicate returns `NO` to every passed 
 object, and so on. Please remember the first object passing test is the object
 returned from this method.
 */
// Memo: I can not write Unit Tests because of runtime failures during instantiation
+ (id)objectOfClass:(Class)objectClassOrNil instantiatedFromNibNamed:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil owner:(id)owner options:(NSDictionary *)options passingTest:(BOOL (^)(id obj, NSInteger idx))predicate;

@end
