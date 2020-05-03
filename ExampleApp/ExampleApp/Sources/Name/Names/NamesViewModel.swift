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

protocol NamesViewModelDelegate: class {
    func userDidSelectName(_ nameModel: NameModelProtocol)
    func userWantsToAddNewName()
}

protocol NamesViewModelDataDelegate: class {
    func modelHasBeenAdded(at indexPath: IndexPath)
    func modelHasBeenDeleted(at indexPath: IndexPath)
    func modelHasBeenDeselected(at indexPath: IndexPath)
}

final class NamesViewModel {
    
    private let namesService: NamesServiceProtocol
    
    weak var delegate: NamesViewModelDelegate?
    weak var dataDelegate: NamesViewModelDataDelegate?
    
    let title: String
    let deleteNameActionTitle: String
    var count: Int {
        return Int(namesService.count())
    }
    
    subscript(indexPath: IndexPath) -> NameModelProtocol? {
        return namesService.name(at: UInt(indexPath.row))
    }
    
    deinit {
        namesService.listenForNewData(listener: nil)
        namesService.listenForRemovedData(listener: nil)
    }
    
    init(namesService: NamesServiceProtocol) {
        self.namesService = namesService
        
        title = L10n.Screen.Names.Navbar.title
        deleteNameActionTitle = L10n.Screen.Names.TableView.Action.deleteName
        
        namesService.listenForNewData { [weak self] index in
            self?.dataDelegate?.modelHasBeenAdded(at: IndexPath(row: index.intValue, section: 0))
        }
        
        namesService.listenForRemovedData { [weak self] index in
            self?.dataDelegate?.modelHasBeenDeleted(at: IndexPath(row: index.intValue, section: 0))
        }
    }
    
    func userWantsToAddNewName() {
        delegate?.userWantsToAddNewName()
    }
    
    func userDidSelectName(at indexPath: IndexPath) {
        dataDelegate?.modelHasBeenDeselected(at: indexPath)
        guard let model = self[indexPath] else {
            return
        }
        delegate?.userDidSelectName(model)
    }
    
    func userWantsToDeleteName(at indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
        guard let model = self[indexPath] else {
            completion(false)
            return
        }
        
        namesService.deleteName(model) {
            completion(true)
        }
    }
    
}
