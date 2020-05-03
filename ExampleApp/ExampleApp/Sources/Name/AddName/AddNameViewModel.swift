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

import UIKit
import ExampleFramework

protocol AddNameViewModelDelegate: class {
    func userDidEndAddingName()
}

final class AddNameViewModel {
    
    private let namesService: NamesServiceProtocol
    
    weak var delegate: AddNameViewModelDelegate?
    
    let title: String
    
    let nameTitle: String
    var name: String?
    var nameValidation: InputValidationState
    
    let nameHistoryTitle: String
    var nameHistory: String?
    var nameHistoryValidation: InputValidationState
    
    init(namesService: NamesServiceProtocol) {
        self.namesService = namesService
        
        title = L10n.Screen.AddName.Navbar.title
        
        nameTitle = L10n.Screen.AddName.Label.newName
        name = nil
        nameValidation = .toEvaluate
        
        nameHistoryTitle = L10n.Screen.AddName.Label.newHistoryName
        nameHistory = nil
        nameHistoryValidation = .toEvaluate
    }
    
    func executeNameAppend() {
        var valid = true
        let validator = namesService.validator()
        if validator.validateName(name) {
            nameValidation = .valid
        } else {
            nameValidation = .invalid(errorMessage: L10n.Screen.AddName.Label.Error.newHistoryName)
            valid = false
        }
        
        if validator.validateNameHistory(nameHistory) {
            nameHistoryValidation = .valid
        } else {
            nameHistoryValidation = .invalid(errorMessage: L10n.Screen.AddName.Label.Error.newName)
            valid = false
        }
        
        guard valid && namesService.append(name, withNameHistory: nameHistory) else {
            return
        }
        
        delegate?.userDidEndAddingName()
    }
    
}
