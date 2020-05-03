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

import Foundation

public protocol CoordinatorProtocol: class {
    
    var parent: CoordinatorProtocol? { get set }
    var children: [CoordinatorProtocol] { get set }
    
    func start()
    
    func childDidFinish(_ child: CoordinatorProtocol)
    
}

// MARK: Helper to remove child coordinator
extension CoordinatorProtocol {
    
    func store(coordinator: CoordinatorProtocol) {
        children.append(coordinator)
    }
    
    func free(coordinator: CoordinatorProtocol) {
        children = children.filter { $0 !== coordinator }
    }
    
    func leaveParent() {
        if let parent = self.parent {
            parent.childDidFinish(self)
        }
    }
    
}

#if DEBUG

extension CoordinatorProtocol {
    
    func className() -> String {
        return "\(self)"
    }
    
    func printChildren() {
        var classes = [Any]()
        children.forEach({
            classes.append([$0.className()])
        })
        print(classes.debugDescription)
    }
    
}

#endif
