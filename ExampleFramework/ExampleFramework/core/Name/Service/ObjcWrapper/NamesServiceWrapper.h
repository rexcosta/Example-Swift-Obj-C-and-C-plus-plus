//
// The MIT License (MIT)
//
// Copyright (c) 2020 Effective Like ABoss, David Costa Gonçalves
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import "NamesServiceProtocol.h"

/// Objc wrapper for C++ NamesService
@interface NamesServiceWrapper : NSObject<NamesServiceProtocol>

- (instancetype _Nonnull)initWithAutoSave:(BOOL)autoSave;

- (id<NameModelValidatorProtocol>_Nonnull)validator;

- (BOOL)append:(NSString *_Nullable)element withNameHistory:(NSString *_Nullable)nameHistory;

- (void)deleteName:(id<NameModelProtocol> _Nonnull)name onCompletion:(void (^_Nonnull)(void))completion;

- (NSUInteger)count;

- (id<NameModelProtocol> _Nullable)nameAtIndex:(NSUInteger)index;

- (void)listenForNewData:(void (^_Nullable)(NSNumber *_Nonnull))newDataListener;

- (void)listenForRemovedData:(void (^_Nullable)(NSNumber *_Nonnull))removedDataListener;

- (void)load;

- (void)save;

@end
