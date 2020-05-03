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

#include "AppleUserDefaultsWrapper.hpp"

#import "AppleUserDefaults.h"

using namespace std;
using namespace example;

struct AppleUserDefaultsWrapper::Internal {
    AppleUserDefaults *appleUserDefaults;
};

AppleUserDefaultsWrapper::AppleUserDefaultsWrapper() {
    internal = make_shared<Internal>();
    internal->appleUserDefaults = [[AppleUserDefaults alloc] init];
}

AppleUserDefaultsWrapper::~AppleUserDefaultsWrapper() {
    
}

void AppleUserDefaultsWrapper::storeValues(string key, IDataStore::StoreValues values) {
    NSMutableArray<NSDictionary<NSString *, NSString *> *> *objcModels = [[NSMutableArray alloc] init];
    
    for (auto const& mapElement: values) {
        NSMutableDictionary<NSString *, NSString *> *objcDictionary = [[NSMutableDictionary alloc] init];
        for (auto const& mapKeyValue: mapElement) {
            NSString *objcKey = [NSString stringWithUTF8String:mapKeyValue.first.c_str()];
            NSString *objcValue = [NSString stringWithUTF8String:mapKeyValue.second.c_str()];
            objcDictionary[objcKey] = objcValue;
        }
        [objcModels addObject:objcDictionary];
    }
    
    NSString *objcKey = [NSString stringWithUTF8String:key.c_str()];
    [internal->appleUserDefaults storeValues:objcModels withKey:objcKey];
}

IDataStore::StoreValues AppleUserDefaultsWrapper::readValues(string key) {
    NSString *objcKey = [NSString stringWithUTF8String:key.c_str()];
    NSArray<NSDictionary<NSString *, NSString *> *> *objcModels = [internal->appleUserDefaults readValuesWithKey:objcKey];
    
    IDataStore::StoreValues vectorValues;
    if (!objcModels) {
        return vectorValues;
    }
    
    for (NSDictionary<NSString *, NSString *> *objcDictionary in objcModels) {
        IDataStore::StoreValue mapValues;
        
        for (NSString *objcDictionaryKey in objcDictionary) {
            string key = string([objcDictionaryKey UTF8String]);
            string value = string([objcDictionary[objcDictionaryKey] UTF8String]);
            mapValues[key] = value;
        }
        
        vectorValues.push_back(mapValues);
    }
    
    return vectorValues;
}
