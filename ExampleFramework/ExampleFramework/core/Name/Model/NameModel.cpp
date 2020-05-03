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

#include "NameModel.hpp"

using namespace std;
using namespace example;

NameModel::NameModel() {
    this->name = "";
    this->nameHistory = "";
    this->id = 0;
}

NameModel::NameModel(string name, string nameHistory, int id) {
    this->name = name;
    this->nameHistory = nameHistory;
    this->id = id;
}

NameModel::~NameModel() {
}

void NameModel::setName(string name) {
    this->name = name;
}

string NameModel::getName() const {
    return name;
}

void NameModel::setNameHistory(string nameHistory) {
    this->nameHistory = nameHistory;
}

string NameModel::getNameHistory() const {
    return nameHistory;
}

int NameModel::getId() const {
    return id;
}

bool NameModel::operator==(const NameModel &rhs) const {
    return id == rhs.getId();
}
