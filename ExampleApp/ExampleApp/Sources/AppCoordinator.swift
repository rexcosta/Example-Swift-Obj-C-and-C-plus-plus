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

final class AppCoordinator: CoordinatorProtocol {
    
    // MARK: CoordinatorProtocol
    var parent: CoordinatorProtocol?
    var children = [CoordinatorProtocol]()
    
    // MARK: Data
    let launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    // MARK: Services
    private let namesService: NamesServiceProtocol
    
    // MARK: UI Navigation
    var router: RouterProtocol?
    
    // MARK: UI Utils
    let window: UIWindow
    
    init(
        window: UIWindow,
        namesService: NamesServiceProtocol,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        self.window = window
        self.namesService = namesService
        self.launchOptions = launchOptions
    }
    
    func start() {
        let navController = UINavigationController()
        let router = NavigationControllerRouter(navigationController: navController)
        self.router = router
        
        let child = NamesCoordinator(
            parent: self,
            router: router,
            namesService: namesService
        )
        children = [child]
        child.start()
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    func childDidFinish(_ child: CoordinatorProtocol) {
    }
    
}
