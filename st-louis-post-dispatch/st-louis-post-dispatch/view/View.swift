//
//  View.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 16/08/24.
//

import Foundation
import UIKit

class View: UIView {
    lazy var header: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.autoresizesSubviews = true
        image.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return image
    }()
    
    lazy var coverImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.autoresizesSubviews = true
        image.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return image
    }()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        subtitle.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return title
    }()
    
    lazy var subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.textAlignment = .center
        subtitle.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return subtitle
    }()
    
    // Implement as TableView for dynamically adding new offers
    // Needs to implement each table cell with two labels and a chack button
    lazy var offersView = UITableView()
    
    // TODO: Needs to implement dropdown menu
    
    private lazy var subscribeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width*0.20, height: 64))
        button.backgroundColor = .blue
        button.tintColor = .white
        button.titleLabel?.text = "Subscribe Now"
        return button
    }()
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(frame: frame)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.autoresizesSubviews = true
        return stackView
    }()
    
    func setup() {
        addSubview(mainStack)
        mainStack.fillSuperView()
        mainStack.addArrangedSubview(header)
        mainStack.addArrangedSubview(title)
        mainStack.addArrangedSubview(subtitle)
        mainStack.addArrangedSubview(subscribeButton)
        subscribeButton.centerXAnchor.constraint(equalTo: mainStack.centerXAnchor).isActive = true
        // TODO: Add the remaining elements and adjust constraints
    }
    
    func updateSubscriptionSection(subscription: Subscription) {
        DispatchQueue.main.async { [weak self] in
            self?.title.text = subscription.subscribeTitle
            self?.subtitle.text = subscription.subscribeSubtitle
        }
    }
    
    func updateHeaderView(withImageFile filename: String) {
        DispatchQueue.main.async { [weak self] in
            self?.header.image = UIImage(contentsOfFile: filename)
        }
    }
    
    func updateCoverView(withImageFile filename: String) {
        DispatchQueue.main.async { [weak self] in
            self?.coverImage.image = UIImage(contentsOfFile: filename)
        }
    }
}

extension UIView {
    func fillSuperView(padding: (left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) = (0, 0, 0, 0)) {
        guard let superview else {
            return
        }
        self.leadingAnchor.constraint(
            equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: padding.left
        ).isActive = true
        self.topAnchor.constraint(
            equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: padding.top
        ).isActive = true
        self.trailingAnchor.constraint(
            equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: padding.right
        ).isActive = true
        self.bottomAnchor.constraint(
            equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: padding.bottom
        ).isActive = true
    }
}
