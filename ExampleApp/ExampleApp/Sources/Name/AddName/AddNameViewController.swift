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

final class AddNameViewController: UIViewController {
    
    // MARK: UI
    private let contentScrollView = UIScrollView()
    private let contentStackView = UIStackView()
    
    private let nameTitleLabel = UILabel()
    private let nameTextField = UITextField()
    private let nameErrorLabel = UILabel()
    
    private let nameHistoryTitleLabel = UILabel()
    private let nameHistoryTextView = UITextView()
    private let nameHistoryErrorLabel = UILabel()
    
    // MARK: Data
    private let viewModel: AddNameViewModel
    
    init(viewModel: AddNameViewModel) {
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
            nameTextField,
            nameErrorLabel,
            UIView.makeLine(with: Theme.shared.lineColor),
            nameHistoryTitleLabel,
            nameHistoryTextView,
            nameHistoryErrorLabel,
            UIView.makeLine(with: Theme.shared.lineColor)
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupContent()
        setupConstraints()
        setupKeyboardDismisser()
        syncWithViewModel()
    }
    
}

// MARK: Setup
extension AddNameViewController {
    
    private func setupNavbar() {
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(onTapAddNewName)
        )
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    private func setupKeyboardDismisser() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onContentViewTap))
        view.addGestureRecognizer(tap)
    }
    
    private func setupContent() {
        view.backgroundColor = Theme.shared.backgroundColor
        
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.keyboardDismissMode = .interactive
        
        contentStackView.setupAsVertical()
        
        nameHistoryTextView.isScrollEnabled = false
        
        Theme.shared.style(
            labels: [nameTitleLabel, nameHistoryTitleLabel],
            .headline
        )
        
        Theme.shared.style(
            labels: [nameErrorLabel, nameHistoryErrorLabel],
            .inputError
        )
        
        Theme.shared.style(textField: nameTextField)
        Theme.shared.style(textView: nameHistoryTextView)
    }
    
    private func setupConstraints() {
        contentStackView.setCustomSpacing(8, after: nameTitleLabel)
        contentStackView.setCustomSpacing(8, after: nameTextField)
        contentStackView.setCustomSpacing(8, after: nameErrorLabel)
        
        contentStackView.setCustomSpacing(8, after: nameHistoryTitleLabel)
        contentStackView.setCustomSpacing(8, after: nameHistoryTextView)
        contentStackView.setCustomSpacing(8, after: nameHistoryErrorLabel)
        
        // Small hack to remove extra margins created by textview
        nameHistoryTextView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: -4)
        
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

// MARK: Actions
extension AddNameViewController {
    
    @objc
    func onTapAddNewName() {
        // We could use combine, or rx to bind variables in the future
        viewModel.name = nameTextField.text
        viewModel.nameHistory = nameHistoryTextView.text
        viewModel.executeNameAppend()
        syncWithViewModel()
    }
    
    @objc
    func onContentViewTap() {
        view.endEditing(true)
    }
    
}

// MARK: ViewModel Sync
extension AddNameViewController {
    
    func syncWithViewModel() {
        // We could use combine, or rx to bind variables in the future
        title = viewModel.title
        
        nameTitleLabel.text = viewModel.nameTitle
        nameTextField.text = viewModel.name
        
        nameHistoryTitleLabel.text = viewModel.nameHistoryTitle
        nameHistoryTextView.text = viewModel.nameHistory
        
        UIView.animate(withDuration: 0.35) {
            self.sync(label: self.nameErrorLabel, with: self.viewModel.nameValidation)
            self.sync(label: self.nameHistoryErrorLabel, with: self.viewModel.nameHistoryValidation)
        }
    }
    
    private func sync(label: UILabel, with validationResult: InputValidationState) {
        switch validationResult {
        case .valid, .toEvaluate:
            label.isHidden = true
            
        case .invalid(errorMessage: let errorMessage):
            label.isHidden = false
            label.text = errorMessage
        }
    }
    
}
