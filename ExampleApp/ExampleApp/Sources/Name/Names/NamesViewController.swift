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

final class NamesViewController: UIViewController {
    
    // MARK: UI
    private let namesTableView = UITableView()
    private let namesCellConfigurator: NamesCellConfigurator
    
    // MARK: Data
    private let viewModel: NamesViewModel
    
    init(viewModel: NamesViewModel) {
        self.viewModel = viewModel
        namesCellConfigurator = NamesCellConfigurator()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = Theme.shared.backgroundColor
        view.disableTranslateAndAddSubview(namesTableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupTableView()
        viewModel.dataDelegate = self
        syncWithViewModel()
    }
    
}

// MARK: Setup
extension NamesViewController {
    
    private func setupNavbar() {
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(onTapAddNewName)
        )
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    private func setupTableView() {
        namesTableView.backgroundColor = nil
        namesCellConfigurator.register(in: namesTableView)
        
        namesTableView.wrapInside(of: view.safeAreaLayoutGuide)
        
        namesTableView.dataSource = self
        namesTableView.delegate = self
    }
    
}

// MARK: Actions
extension NamesViewController {
    
    @objc
    func onTapAddNewName() {
        viewModel.userWantsToAddNewName()
    }
    
}

// MARK: NamesViewModelDataDelegate
extension NamesViewController: NamesViewModelDataDelegate {
    
    func modelHasBeenAdded(at indexPath: IndexPath) {
        namesTableView.beginUpdates()
        namesTableView.insertRows(at: [indexPath], with: .automatic)
        namesTableView.endUpdates()
    }
    
    func modelHasBeenDeleted(at indexPath: IndexPath) {
        namesTableView.beginUpdates()
        namesTableView.deleteRows(at: [indexPath], with: .automatic)
        namesTableView.endUpdates()
    }
    
    func modelHasBeenDeselected(at indexPath: IndexPath) {
        namesTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: UITableViewDataSource
extension NamesViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        return namesCellConfigurator.trailingActions(at: indexPath, tableView: tableView, viewModel: viewModel)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return namesCellConfigurator.cell(at: indexPath, tableView: tableView, viewModel: viewModel)
    }
    
}

// MARK: UITableViewDelegate
extension NamesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userDidSelectName(at: indexPath)
    }
    
}

// MARK: ViewModel Sync
extension NamesViewController {
    
    func syncWithViewModel() {
        // We could use combine, or rx to bind variables in the future
        title = viewModel.title
    }
    
}
