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

#include <algorithm>

#include "AppleUserDefaultsWrapper.hpp"
#include "IDataStore.hpp"
#include "NamesService.hpp"
#include "NameModel.hpp"
#include "NameModelSerializer.hpp"
#include "NameModelValidator.hpp"
#include "Logger.hpp"

using namespace std;
using namespace example;

NamesService::NamesService() {
    idGenerator = 0;
}

NamesService::~NamesService() {
}

bool NamesService::addName(string name, string nameHistory) {
    if (!validateModelData(name, nameHistory)) {
        LOG("[NamesService] Couldn't create invalid name");
        return false;
    }
    
    auto id = ++idGenerator;
    LOG("[NamesService] Creating name %s id with id %d", name.c_str(), id);
    
    addNameModel(make_shared<NameModel>(name, nameHistory, id), autoSave);
    return true;
}

void NamesService::deleteName(const int id) {
    auto removeNameModel = [id](const shared_ptr<const NameModel> nameModel) -> bool {
        return nameModel->getId() == id;
    };
    
    auto elementIterator = find_if(namesVector.begin(), namesVector.end(), removeNameModel);
    if (elementIterator == namesVector.end()) {
        LOG("[NamesService] Attemped to delete id %d", id);
        return;
    }
    
    auto index = distance(namesVector.begin(), elementIterator);
    LOG("[NamesService] Deleting id %d at %ld", id, index);
    
    namesVector.erase(elementIterator);
    if (removedDataCallback) {
        removedDataCallback(index);
    }
}

shared_ptr<NameModel> NamesService::get(size_t index) const {
    if (index > namesVector.size()) {
        LOG("[NamesService] Invalid index %ld to fetch the name", index);
        return nullptr;
    }
    return namesVector[index];
}

size_t NamesService::size() const {
    return namesVector.size();
}

void NamesService::listenForNewData(const function<void (size_t)> callback) {
    newDataCallback = callback;
}

void NamesService::listenForRemovedData(function<void(size_t)> callback) {
    removedDataCallback = callback;
}

void NamesService::setAutoSave(bool autoSave) {
    this->autoSave = autoSave;
}

void NamesService::save() {
    LOG("[NamesService] Save started");
    
    AppleUserDefaultsWrapper dataStore;
    IDataStore::StoreValues values;
    
    NameModelSerializer serializer;
    for (auto const& nameModel: namesVector) {
        auto nameMap = serializer.serialize(*nameModel);
        values.push_back(nameMap);
    }
    
    dataStore.storeValues("names", values);
    
    LOG("[NamesService] Save ended");
}

void NamesService::load() {
    LOG("[NamesService] Load started");
    
    AppleUserDefaultsWrapper dataStore;
    auto arrayValues = dataStore.readValues("names");
    
    NameModelSerializer serializer;
    for (auto const& nameMap: arrayValues) {
        auto id = ++idGenerator;
        auto result = serializer.deserialize(nameMap, id);
        if (result && validateModelData(*result)) {
            addNameModel(result, false);
        }
    }
    
    LOG("[NamesService] Load ended");
}

void NamesService::addNameModel(shared_ptr<NameModel> nameModel, bool shouldSave) {
    namesVector.push_back(nameModel);
    if (newDataCallback) {
        auto lastIndex = namesVector.size() - 1;
        newDataCallback(lastIndex);
    }
    if (shouldSave) {
        save();
    }
}

bool NamesService::validateModelData(const NameModel &gameModel) {
    return validateModelData(gameModel.getName(), gameModel.getNameHistory());
}

bool NamesService::validateModelData(string name, string nameHistory) {
    NameModelValidator validator;
    return validator.validateName(name) && validator.validateName(nameHistory);
}
