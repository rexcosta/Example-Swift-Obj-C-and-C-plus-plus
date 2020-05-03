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

#ifndef NameModel_H
#define NameModel_H

#include <string>

namespace example {
    
    /// The C++ implementation for NameModelProtocol
    /// This could also have a interface in C++, but not making it yet, to keep things simple
    /// Check NameModelWrapper for Obj-C and swift exposure
    class NameModel {
        
    public:
        NameModel();
        NameModel(std::string name, std::string nameHistory, int id);
        virtual ~NameModel();
        
        void setName(std::string name);
        
        std::string getName() const;
        
        void setNameHistory(std::string name);
        
        std::string getNameHistory() const;
        
        int getId() const;
        
        bool operator==(const NameModel &rhs) const;
        
    private:
        int id;
        std::string name;
        std::string nameHistory;
    };
    
}

#endif /* NameModel_H */
