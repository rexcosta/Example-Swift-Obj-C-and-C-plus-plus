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

final class NameCoordinator: CoordinatorProtocol {
    
    // MARK: CoordinatorProtocol
    var parent: CoordinatorProtocol?
    var children = [CoordinatorProtocol]()
    
    // MARK: UI Navigation
    private let router: RouterProtocol
    
    // MARK: Data
    private let nameModel: NameModelProtocol
    
    init(parent: CoordinatorProtocol, router: RouterProtocol, nameModel: NameModelProtocol) {
        self.parent = parent
        self.router = router
        self.nameModel = nameModel
    }
    
    func start() {
        let viewModel = NameViewModel(nameModel: nameModel)
        let viewController = NameViewController(viewModel: viewModel)
        let onNavigateBack: NavigationBackClosure = { [weak self] in
            self?.leaveParent()
        }
        router.push(viewController, animated: true, onNavigateBack: onNavigateBack)
    }
    
    func childDidFinish(_ child: CoordinatorProtocol) {
    }
    
}
