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

#import "NamesServiceWrapper.h"
#import "NameModelWrapper.h"
#import "NameModelValidatorWrapper.h"

#include "NamesService.hpp"

using namespace std;
using namespace example;

@interface NamesServiceWrapper() {
    NamesService namesService;
}

@end

@implementation NamesServiceWrapper

- (instancetype)initWithAutoSave:(BOOL)autoSave {
    if (self = [super init]) {
        if (autoSave) {
            namesService.setAutoSave(true);
        } else {
            namesService.setAutoSave(false);
        }
    }
    return self;
}

- (id<NameModelValidatorProtocol>)validator {
    return [[NameModelValidatorWrapper alloc] init];
}

- (BOOL)append:(NSString *)name withNameHistory:(NSString *)nameHistory {
    if (!name) {
        name = @"";
    }
    if (!nameHistory) {
        nameHistory = @"";
    }
    
    if (namesService.addName(string([name UTF8String]), string([nameHistory UTF8String]))) {
        return YES;
    }
    return NO;
}

- (void)deleteName:(id<NameModelProtocol>)name onCompletion:(void (^)(void))completion {
    namesService.deleteName(name.identifier.intValue);
    completion();
}

- (NSUInteger)count {
    return namesService.size();
}

- (id<NameModelProtocol>)nameAtIndex:(NSUInteger)index {
    auto model = namesService.get(index);
    if (!model) {
        return nil;
    }
    return [[NameModelWrapper alloc] initWithNameModel:model];
}

- (void)listenForNewData:(void (^)(NSNumber *))newDataListener {
    if (!newDataListener) {
        namesService.listenForNewData(nullptr);
        return;
    }
    
    auto listener = [newDataListener, self](size_t index){
        newDataListener(@(index));
    };
    namesService.listenForNewData(listener);
}

- (void)listenForRemovedData:(void (^_Nullable)(NSNumber *_Nonnull))removedDataListener {
    if (!removedDataListener) {
        namesService.listenForRemovedData(nullptr);
        return;
    }
    
    auto listener = [removedDataListener, self](size_t index){
        removedDataListener(@(index));
    };
    namesService.listenForRemovedData(listener);
}

- (void)load {
    namesService.load();
}

- (void)save {
    namesService.save();
}

@end
