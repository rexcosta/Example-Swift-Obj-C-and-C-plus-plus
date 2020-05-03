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

final class NameViewController: UIViewController {
    
    // MARK: UI
    private let contentScrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private let nameTitleLabel = UILabel()
    private let nameLabel = UILabel()
    private let nameHistoryTitleLabel = UILabel()
    private let nameHistoryLabel = UILabel()
    
    // MARK: Data
    private let viewModel: NameViewModel
    
    init(viewModel: NameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.disableTranslateAndAddSubview(contentScrollView)
        contentScrollView.disableTranslateAndAddSubview(contentStackView)
        contentStackView.addArrangedSubviews(
            nameTitleLabel,
            nameLabel,
            nameHistoryTitleLabel,
            nameHistoryLabel
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
        setupConstraints()
        syncWithViewModel()
    }
    
}

// MARK: Setup
extension NameViewController {
    
    private func setupContent() {
        view.backgroundColor = Theme.shared.backgroundColor
        
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.keyboardDismissMode = .interactive
        
        contentStackView.setupAsVertical()
        
        Theme.shared.style(
            labels: [nameTitleLabel, nameHistoryTitleLabel],
            .headline
        )
        
        Theme.shared.style(
            labels: [nameLabel, nameHistoryLabel],
            .body
        )
    }
    
    private func setupConstraints() {
        contentStackView.setCustomSpacing(8, after: nameTitleLabel)
        contentStackView.setCustomSpacing(32, after: nameLabel)
        
        contentStackView.setCustomSpacing(8, after: nameHistoryTitleLabel)
        contentStackView.setCustomSpacing(8, after: nameHistoryLabel)
        
        contentScrollView.wrapInside(of: view.safeAreaLayoutGuide)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentScrollView.bottomAnchor),
            
            contentStackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
}

// MARK: ViewModel Sync
extension NameViewController {
    
    func syncWithViewModel() {
        // We could use combine, or rx to bind variables in the future
        title = viewModel.title
        
        nameTitleLabel.text = viewModel.nameTitle
        nameLabel.text = viewModel.name
        
        nameHistoryTitleLabel.text = viewModel.nameHistoryTitle
        nameHistoryLabel.text = viewModel.nameHistory
    }
    
}
