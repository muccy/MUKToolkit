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

#import "MUK+Object.h"
#import "MUK+Array.h"

@implementation MUK (Object)

+ (id)objectOfClass:(Class)objectClass instantiatedFromNibNamed:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil owner:(id)owner options:(NSDictionary *)options passingTest:(BOOL (^)(id, NSInteger))predicate
{
    nibNameOrNil = nibNameOrNil ?: NSStringFromClass(objectClass);
    if (nibNameOrNil == nil) return nil;
    
    bundleOrNil = bundleOrNil ?: [NSBundle mainBundle];
    
    UINib *nib = [UINib nibWithNibName:nibNameOrNil bundle:bundleOrNil];
    NSArray *objects = [nib instantiateWithOwner:owner options:options];
    
    __block id matchingObject = nil;
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (objectClass) {
            // If should filter by object class
            if ([obj isMemberOfClass:objectClass]) {
                // If class matches
                if (predicate) {
                    // If should filter by predicate, too
                    if (predicate(obj, idx)) {
                        // If predicate matches
                        matchingObject = obj;
                        *stop = YES;
                    }
                    // if predicate does not match, pass to next object
                }
                else {
                    // If should not filter by predicate, take first object
                    // which has matching class
                    matchingObject = obj;
                    *stop = YES;
                } // if/else predicate
            } // if obj class matches
            // if obj class does not match, so object is not valid
        }
        else {
            // If should not filter by class
            if (predicate) {
                // If should filter by predicate
                if (predicate(obj, idx)) {
                    // If predicate matches
                    matchingObject = obj;
                    *stop = YES;
                }
                // If predicate does not match, pass to next object
            }
            else {
                // If should not filter by predicate, take first object you find
                matchingObject = obj;
                *stop = YES;
            } // if/else predicate
        } // if/else objectClass
    }]; // enumerateObjectsUsingBlock
    
    return matchingObject;
}

@end
