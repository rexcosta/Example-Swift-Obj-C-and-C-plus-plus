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

#include "NameModelSerializer.hpp"
#include "Logger.hpp"

using namespace std;
using namespace example;

IDataStore::StoreValue NameModelSerializer::serialize(const NameModel &nameModel) {
    IDataStore::StoreValue nameMap;
    nameMap["name"] = nameModel.getName();
    nameMap["nameHistory"] = nameModel.getNameHistory();
    return nameMap;
}

shared_ptr<NameModel> NameModelSerializer::deserialize(IDataStore::StoreValue value, int newId) {
    if (value.find("name") == value.end()) {
        LOG("[NameModelSerializer] Deserialize didn't found name");
        return nullptr;
    }
    if (value.find("nameHistory") == value.end()) {
        LOG("[NameModelSerializer] Deserialize didn't found nameHistory");
        return nullptr;
    }
    auto name = value.at("name");
    auto nameHistory = value.at("nameHistory");
    return make_shared<NameModel>(name, nameHistory, newId);
}
