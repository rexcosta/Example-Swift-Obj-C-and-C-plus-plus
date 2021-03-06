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

#ifndef NameModelSerializer_H
#define NameModelSerializer_H

#include "IDataStore.hpp"
#include "NameModel.hpp"

namespace example {
    
    /// The C++ implementation for name model serialization
    /// This could also have a interface in C++, for diferent kinds of serialization but not making it yet, to keep things simple
    /// This class is not exposed to obj-c or swift
    class NameModelSerializer {
        
    public:
        
        NameModelSerializer() { };
        
        virtual ~NameModelSerializer() { };
        
        IDataStore::StoreValue serialize(const NameModel &nameModel);
        
        std::shared_ptr<NameModel> deserialize(IDataStore::StoreValue value, int newId);
        
    };
    
}

#endif /* NameModelSerializer_H */
