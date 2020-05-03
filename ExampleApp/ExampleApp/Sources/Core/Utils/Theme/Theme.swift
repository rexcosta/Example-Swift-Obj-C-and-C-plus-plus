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

struct Theme {
    
    static let shared = Theme()
    
    let tintColor: UIColor
    let backgroundColor: UIColor
    let secondaryBackgroundColor: UIColor
    
    let lineColor: UIColor
    
    let primaryTextColor: UIColor
    let secondaryTextColor: UIColor
    let inputErrorTextColor: UIColor
    
    private init() {
        tintColor = .systemBlue
        backgroundColor = .systemBackground
        secondaryBackgroundColor = .secondarySystemBackground
        lineColor = .opaqueSeparator
        primaryTextColor = UIColor.theme(
            light: .black,
            dark: .white
        )
        secondaryTextColor = .systemGray
        inputErrorTextColor = .systemRed
    }
    
}

// MARK: - Style Label
extension Theme {

    func style(label: UILabel, _ style: FontStyle) {
        self.style(labels: [label], style)
    }
    
    func style(labels: [UILabel], _ style: FontStyle) {
        labels.forEach {
            $0.font = font(for: style)
            $0.textColor = color(for: style)
            $0.textAlignment = .natural
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.adjustsFontForContentSizeCategory = true
        }
    }
    
}

// MARK: - Style Input
extension Theme {
    
    func style(textField: UITextField) {
        let style = FontStyle.inputBody
        textField.font = font(for: style)
        textField.textColor = color(for: style)
        textField.adjustsFontForContentSizeCategory = true
    }
    
    func style(textView: UITextView) {
        let style = FontStyle.inputBody
        textView.font = font(for: style)
        textView.textColor = color(for: style)
        textView.backgroundColor = .clear
        textView.adjustsFontForContentSizeCategory = true
    }
    
}

// MARK: - Style Cell
extension Theme {
    
    func style(cell: UITableViewCell) {
        cell.backgroundColor = nil
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = Theme.shared.secondaryBackgroundColor
        cell.selectedBackgroundView = bgColorView
    }
    
}

// MARK: - Font
extension Theme {
    
    private func color(for style: FontStyle) -> UIColor {
        switch style {
        case .headline:
            return secondaryTextColor
            
        case .body, .inputBody:
            return primaryTextColor
            
        case .inputError:
            return inputErrorTextColor
        }
    }
    
    private func font(for style: FontStyle) -> UIFont {
        return Theme.makeFont(style)
    }
    
    private static func makeFont(_ style: FontStyle) -> UIFont {
        switch style {
        case .headline:
            return UIFont.preferredFont(forTextStyle: .subheadline)
            
        case .body, .inputBody:
            return UIFont.preferredFont(forTextStyle: .body)
            
        case .inputError:
            return UIFont.preferredFont(forTextStyle: .footnote)
        }
    }
    
}
