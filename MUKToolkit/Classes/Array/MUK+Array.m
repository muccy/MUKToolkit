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

#import "MUK+Array.h"

@implementation MUK (Array)

+ (id)array:(NSArray *)array objectAtIndex:(NSInteger)index {
    if (index >= 0 && index < [array count]) {
        return [array objectAtIndex:index];
    }
    
    return nil;
}

+ (NSArray *)array:(NSArray *)array map:(id (^)(id, NSInteger, BOOL *, BOOL *))block
{
    if (block == nil || [array count] == 0) return array;
    
    NSMutableArray *mappedArray = [NSMutableArray arrayWithCapacity:[array count]];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BOOL exclusionRequested = NO, stopRequested = NO;
        id mappedObject = block(obj, idx, &exclusionRequested, &stopRequested);
        
        if (stopRequested) {
            *stop = stopRequested;
        }
        else if (exclusionRequested == NO) {
            mappedObject = mappedObject ?: [NSNull null];
            [mappedArray addObject:mappedObject];
        }
    }];
    
    return mappedArray;
}

+ (NSArray *)array:(NSArray *)array applyingTransform:(MUKArrayTransform)transform
{
    NSArray *output = array;
    
    switch (transform) {
        case MUKArrayTransformReverse:
            // Elegant solution from http://stackoverflow.com/a/586529
            output = [[array reverseObjectEnumerator] allObjects];
            break;
            
        default:
            break;
    }
    
    return output;
}

@end
