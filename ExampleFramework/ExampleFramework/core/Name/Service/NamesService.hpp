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

#ifndef NamesService_H
#define NamesService_H

#include <functional>
#include <string>
#include <vector>

namespace example {

    class NameModel;
    
    /// The C++ implementation for NamesServiceProtocol
    /// This could also have a interface in C++, but not making it yet, to keep things simple
    /// Check NamesServiceWrapper for Obj-C and swift exposure
    class NamesService {
        
    public:
        NamesService();
        virtual ~NamesService();
        
        bool addName(std::string name, std::string nameHistory);
        
        void deleteName(const int id);
        
        std::shared_ptr<NameModel> get(size_t index) const;
        
        size_t size() const;
        
        void listenForNewData(std::function<void(size_t)> callback);
        
        void listenForRemovedData(std::function<void(size_t)> callback);
        
        void setAutoSave(bool autoSave);
        
        void save();
        
        void load();
        
    private:
        std::vector<std::shared_ptr<NameModel>> namesVector;
        std::function<void (size_t)> newDataCallback;
        std::function<void (size_t)> removedDataCallback;
        int idGenerator;
        bool autoSave;
        
        void addNameModel(std::shared_ptr<NameModel> nameModel, bool shouldSave);
        bool validateModelData(const NameModel &gameModel);
        bool validateModelData(std::string name, std::string nameHistory);
    };
    
}

#endif /* NamesService_H */
