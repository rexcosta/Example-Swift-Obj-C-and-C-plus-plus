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

final class AddNameCoordinator: CoordinatorProtocol {
    
    // MARK: CoordinatorProtocol
    var parent: CoordinatorProtocol?
    var children = [CoordinatorProtocol]()
    
    // MARK: UI Navigation
    private let router: RouterProtocol
    
    // MARK: Services
    private let namesService: NamesServiceProtocol
    
    init(parent: CoordinatorProtocol, router: RouterProtocol, namesService: NamesServiceProtocol) {
        self.parent = parent
        self.router = router
        self.namesService = namesService
    }
    
    func start() {
        let viewModel = AddNameViewModel(namesService: namesService)
        viewModel.delegate = self
        let viewController = AddNameViewController(viewModel: viewModel)
        let onDismiss: DismissClosure = { [weak self] in
            self?.leaveParent()
        }
        // Wrap in navcontroller for navigation bar native support
        let navController = UINavigationController(rootViewController: viewController)
        router.present(navController, animated: true, onDismiss: onDismiss, onDidShow: nil)
    }
    
    func childDidFinish(_ child: CoordinatorProtocol) {
    }
    
}

// MARK: AddNameViewModelDelegate
extension AddNameCoordinator: AddNameViewModelDelegate {
    
    func userDidEndAddingName() {
        router.dismiss(animated: true)
    }
    
}
